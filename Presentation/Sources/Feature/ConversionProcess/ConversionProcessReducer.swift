//
//  ConversionProcessReducer.swift
//  Presentation
//
//  Created by 디해 on 7/12/25.
//

import ComposableArchitecture
import Shared
import Entity
import Foundation
import UIKit
import Logger
import Minifire

@Reducer
struct ConversionProcessReducer {
    @Dependency(\.fetchConvertedRecipeIDUseCase) var fetchConvertedRecipeIDUseCase
    @Dependency(\.fetchRecipeStateUseCase) var fetchRecipeStateUseCase
    @Dependency(\.fetchRecipeDetailUseCase) var fetchRecipeDetailUseCase
    @Dependency(\.logger) var logger
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State: Equatable {
        let recipeSource: String
        var recipeConversionID: Int64?
        
        var errorState = ErrorHandlingState()
    }
    
    enum Action: Equatable {
        case onAppear
        case recipeConversionResponse(Int64)
        
        case startPolling
        case stopPolling
        case pollTick
        case pollResponse(RecipeStateViewData)
        case loadCompletedRecipe
        
        case appDidEnterBackground
        case appWillEnterForeground
        
        case showError(ErrorDisplayType)
        case clearError
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                logger.track(.conversionProcessScreen)
                return reduceOnAppear(&state)
                
            case .recipeConversionResponse(let uuid):
                return reduceRecipeConversionResponse(&state, id: uuid)
                
            case .startPolling:
                return reduceStartPolling()
                
            case .stopPolling:
                return .cancel(id: CancelID.polling)
                
            case .pollTick:
                return reducePollTick(state)
                
            case .pollResponse(let recipeState):
                return reducePollResponse(state: recipeState)
                
            case .loadCompletedRecipe:
                guard let id = state.recipeConversionID else { return .none }
                return .run { send in
                    let result = await fetchRecipeDetailUseCase.execute(recipeID: id)
                    
                    switch result {
                    case .success(let detail):
                        let preview = detail.toRecipePreviewViewData()
                        await send(.delegate(.navigateToResult(preview)))
                        
                    case .failure(let error):
                        let errorType = ErrorDisplayType.dialog(
                            title: "로드 실패",
                            message: "완성된 레시피 정보를 불러오는데 실패했습니다.",
                            showBackButton: true
                        )
                        
                        await send(.showError(errorType))
                    }
                }
                
            case .appDidEnterBackground:
                return .send(.stopPolling)
                
            case .appWillEnterForeground:
                guard state.recipeConversionID != nil else { return .none }
                return .send(.startPolling)
                
            case .showError(let errorType):
                state.errorState.showError(errorType)
                return .none
                
            case .clearError:
                state.errorState.clearError()
                return .run { _ in
                    await dismiss()
                }
                
            case .delegate:
                return .none
            }
        }
    }
}

private extension ConversionProcessReducer {
    func reduceOnAppear(_ state: inout State) -> Effect<Action> {
        let source = state.recipeSource
        
        return .run { send in
            let result = await fetchConvertedRecipeIDUseCase.execute(source)
            switch result {
            case .success(let id):
                await send(.delegate(.refresh))
                await send(.recipeConversionResponse(id))
            case .failure(let error):
                let errorType = ErrorDisplayType.dialog(
                    title: "오류가 발생하였습니다",
                    message: "인터넷 연결 상태를 확인하고 다시 시도해주세요.",
                    showBackButton: true
                )
                
                await send(.showError(errorType))
            }
        }
    }
    
    func reduceRecipeConversionResponse(_ state: inout State, id: Int64) -> Effect<Action> {
        state.recipeConversionID = id
        return .send(.startPolling)
    }
    
    func reduceStartPolling() -> Effect<Action> {
        return .run { send in
            for await _ in Timer
                .publish(every: 5, on: .main, in: .default)
                .autoconnect()
                .values {
                await send(.pollTick)
            }
        }
        .cancellable(id: CancelID.polling)
    }
    
    func reducePollTick(_ state: State) -> Effect<Action> {
        guard let id = state.recipeConversionID else { return .none }
        
        return .run { send in
            let result = await fetchRecipeStateUseCase.execute(recipeID: id)
            switch result {
            case .success(let state):
                let recipeState = state.toRecipeStateViewData()
                
                await send(.pollResponse(recipeState))
                
            case .failure(let error):
                print(">>> \(error)")
            }
        }
    }
    
    func reducePollResponse(state: RecipeStateViewData) -> Effect<Action> {
        if state == .completed {
            return .concatenate(
                .send(.stopPolling),
                .send(.loadCompletedRecipe)
            )
        } else if state == .failed {
            return .concatenate(
                .send(.stopPolling),
                .send(.delegate(.navigateToFailed))
            )
        }
        
        return .send(.delegate(.refresh))
    }
}

extension RecipeDetailVO {
    func toRecipePreviewViewData() -> RecipePreviewViewData {
        return RecipePreviewViewData(
            recipeID: self.recipeID,
            thumbnail: self.thumbnailURL,
            title: self.title,
            serving: "\(self.serving)\(LocalizationHelper.recipeServingUnit)",
            steps: self.stages.map { $0.toStepViewData() }
        )
    }
}

extension RecipeStateVO {
    func toRecipeStateViewData() -> RecipeStateViewData {
        switch self {
        case .pending:
            return .inProgress
        case .pended:
            return .inProgress
        case .verifying:
            return .inProgress
        case .verified:
            return .inProgress
        case .transforming:
            return .inProgress
        case .transformed:
            return .inProgress
        case .processing:
            return .inProgress
        case .evaluating:
            return .inProgress
        case .completed:
            return .completed
        case .failed:
            return .failed
        case .cancelled:
            return .failed
        case .unknown:
            return .failed
        }
    }
}

extension ConversionProcessReducer {
    enum CancelID {
        case polling
    }
    
    enum Delegate: Equatable {
        case refresh
        case startedConvertingRecipe(Int64)
        case navigateToResult(RecipePreviewViewData)
        case navigateToFailed
    }
}

extension MFError: @retroactive LocalizedError {
    public var errorDescription: String? {
        self.description
    }
}
