import XCTest
import ComposableArchitecture
import Entity
import Domain
@testable import Presentation
@testable import Logger

final class HomeReducerTests: XCTestCase {
    
    // MARK: - 폴링 시작 테스트
    
    @MainActor
    func test_checkIfNeedsPolling_시작조건_완료되지않은레시피가있을때() async {
        let clock = TestClock()
        let mockLogger = MockLogger()
        
        // Given: 완료되지 않은 레시피가 이미 상태에 있는 경우
        let incompletedRecipe = RecipeListItem(
            recipeID: 1,
            thumbnail: nil,
            title: "테스트 레시피",
            servings: 2,
            ingredients: "재료1 100g",
            state: .inProgress
        )
        
        let store = TestStore(
            initialState: HomeReducer.State(
                recipes: [RecipeListItemReducer.State(item: incompletedRecipe)]
            )
        ) {
            HomeReducer()
        } withDependencies: {
            $0.continuousClock = clock
            $0.logger = mockLogger
            $0.incompletedRecipeIDStore = IncompleteRecipeStore<Int64>()
        }
        store.exhaustivity = .off
        
        // When: 폴링 체크 실행
        await store.send(.checkIfNeedsPolling)
        
        // Then: 폴링이 시작되어야 함
        await store.receive(.startPolling, timeout: .seconds(2))
    }
    
    @MainActor
    func test_checkIfNeedsPolling_시작안함_모든레시피가완료됨() async {
        // Given: 모든 레시피가 완료된 상태
        let completedRecipe = RecipeListItem(
            recipeID: 1,
            thumbnail: nil,
            title: "완료된 레시피",
            servings: 2,
            ingredients: "재료",
            state: .completed
        )
        
        let store = TestStore(
            initialState: HomeReducer.State(
                recipes: [RecipeListItemReducer.State(item: completedRecipe)]
            )
        ) {
            HomeReducer()
        }
        
        // When: 폴링 체크 실행
        await store.send(.checkIfNeedsPolling)
        
        // Then: 폴링이 시작되지 않아야 함 (추가 액션 없음)
    }
    
    // MARK: - 폴링 타이머 테스트
    
    @MainActor
    func test_startPolling_타이머설정_5초간격() async {
        let clock = TestClock()
        
        let store = TestStore(initialState: HomeReducer.State()) {
            HomeReducer()
        } withDependencies: {
            $0.continuousClock = clock
            $0.incompletedRecipeIDStore = IncompleteRecipeStore<Int64>()
        }
        store.exhaustivity = .off
        
        // When: 폴링 시작
        await store.send(.startPolling)
        
        // 5초 진행
        await clock.advance(by: .seconds(5))
        await store.receive(.pollTick)
        
        // 추가 5초 진행 (아이디가 비었으므로 cancel)
        await clock.advance(by: .seconds(5))
        await store.receive(.cancelTick)
    }
    
    // MARK: - API 호출 테스트
    
    @MainActor
    func test_pollTick_API호출성공_완료된레시피목록반환() async {
        let mockPreviewUseCase = MockFetchRecipePreviewUseCase()
        let mockUseCase = MockFetchCompletedRecipeConversionIDsUseCase()
        mockUseCase.resultToReturn = .success([1, 2])
        
        let store = TestStore(initialState: HomeReducer.State()) {
            HomeReducer()
        } withDependencies: {
            $0.fetchRecipePreviewUseCase = mockPreviewUseCase
            $0.fetchCompletedRecipeConversionIDsUseCase = mockUseCase
            $0.incompletedRecipeIDStore = IncompleteRecipeStore<Int64>(ids: [1, 2, 3])
        }
        store.exhaustivity = .off
        
        // When: 폴링 틱 실행
        await store.send(.pollTick)
        
        // Then: 완료된 레시피 ID 응답 처리
        await store.receive(.completedRecipeIDsRepsponse([1, 2]))
    }
    
    // MARK: - 완료된 레시피 처리 테스트
    
    @MainActor
    func test_completedRecipeIDsResponse_레시피상태업데이트() async {
        let mockPreviewUseCase = MockFetchRecipePreviewUseCase()
        let updatedRecipe = RecipePreviewVO(
            recipeID: 1,
            thumbnailURL: nil,
            title: "업데이트된 레시피",
            servings: 2,
            ingredients: [],
            state: "COMPLETED"
        )
        mockPreviewUseCase.resultToReturn = .success(updatedRecipe)
        
        let store = TestStore(initialState: HomeReducer.State()) {
            HomeReducer()
        } withDependencies: {
            $0.fetchRecipePreviewUseCase = mockPreviewUseCase
            $0.incompletedRecipeIDStore = IncompleteRecipeStore<Int64>()
        }
        
        // When: 완료된 레시피 ID 처리
        await store.send(.completedRecipeIDsRepsponse([1]))
        
        // Then: 레시피 상태가 업데이트됨
        await store.receive(.updateRecipe(updatedRecipe.toRecipeListItem()))
    }
    
    // MARK: - 폴링 중단 테스트
    
    @MainActor
    func test_cancelTick_폴링중단_타이머정리() async {
        let store = TestStore(initialState: HomeReducer.State()) {
            HomeReducer()
        }
        
        // When: 폴링 중단
        await store.send(.cancelTick)
        
        // Then: 타이머가 정리되어야 함 (메모리 누수 방지)
        // TestStore가 자동으로 취소된 이펙트를 검증함
    }
    
    // MARK: - 폴링 빈도 제한 테스트
    
    @MainActor
    func test_pollTick_빈ID목록_자동폴링중단() async {
        let mockStore = IncompleteRecipeStore<Int64>()
        
        let store = TestStore(initialState: HomeReducer.State()) {
            HomeReducer()
        } withDependencies: {
            $0.incompletedRecipeIDStore = mockStore
        }
        
        // When: 완료되지 않은 레시피가 없는 상태에서 폴링
        await store.send(.pollTick)
        
        // Then: 자동으로 폴링 중단
        await store.receive(.cancelTick)
    }
}

// 완료된 레시피 변환 ID 조회 UseCase Mock
class MockFetchCompletedRecipeConversionIDsUseCase: FetchCompletedRecipeConversionIDsUseCase {
    var resultToReturn: Result<[Int64], Error> = .success([])
    
    func execute(ids: [Int64]) async throws -> [Int64] {
        switch resultToReturn {
        case .success(let ids):
            return ids
        case .failure(let error):
            throw error
        }
    }
}

class MockFetchRecipePreviewsUseCase: FetchRecipePreviewsUseCase {
    var resultToReturn: Result<RecipeListVO, Error> = .success(
        RecipeListVO(
            previews: [],
            hasNext: false,
            cursorId: 0
        )
    )
    
    func execute(cursorId: Int?, size: Int) async -> Result<RecipeListVO, any Error> {
        return resultToReturn
    }
}

class MockLogger: Logger {
    func track(_ event: LogEvent) { }
}

// MARK: - Extensions for Tests
extension RecipePreviewVO {
    func toRecipeListItem() -> RecipeListItem {
        return RecipeListItem(
            recipeID: self.recipeID,
            thumbnail: self.thumbnailURL,
            title: self.title,
            servings: self.servings,
            ingredients: self.ingredients.map { "\($0.name) \($0.amount)" }.joined(separator: ", "),
            state: self.state.toRecipeStateViewData()
        )
    }
}

extension RecipeStateVO {
    func toRecipeStateViewData() -> RecipeStateViewData {
        switch self {
        case .completed:
            return .completed
        case .failed, .cancelled:
            return .failed
        default:
            return .inProgress
        }
    }
}

// 레시피 미리보기 조회 UseCase Mock
class MockFetchRecipePreviewUseCase: FetchRecipePreviewUseCase {
    var resultToReturn: Result<RecipePreviewVO, Error> = .success(
        RecipePreviewVO(
            recipeID: 1,
            thumbnailURL: nil,
            title: "Test",
            servings: 1,
            ingredients: [],
            state: "COMPLETED"
        )
    )
    
    func execute(recipeID: Int64) async -> Result<RecipePreviewVO, Error> {
        return resultToReturn
    }
}
