//
//  SplashReducer.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SplashReducer {
    @Dependency(\.fetchIntroUseCase) var fetchIntroUseCase
    
    @ObservableState
    struct State {
        let appTitle: String = "내 손 안의 요리 도우미"
        let appIconName: String = "splash_icon"
        var introState: IntroStateViewData = .idle
    }
    
    enum Action {
        case onAppear
        case introResponse(Result<IntroViewData, Error>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return reduceOnAppear()
                
            case .introResponse(let result):
                return reduceIntroResponse(&state, result: result)
            }
        }
    }
}

private extension SplashReducer {
    func reduceOnAppear() -> Effect<Action> {
        .run { send in
            let introResult = await fetchIntroUseCase.execute()
            
            switch introResult {
            case .success(let intro):
                await send(.introResponse(.success(intro.toIntroViewData())))
            case .failure(let error):
                await send(.introResponse(.failure(error)))
            }
        }
    }
    
    func reduceIntroResponse(
        _ state: inout SplashReducer.State,
        result: Result<IntroViewData, Error>
    ) -> Effect<Action> {
        switch result {
        case .success(let data):
            state.introState = .success(data)
        case .failure(let error):
            state.introState = .failure(error)
        }
        
        return .none
    }
}

private extension Intro {
    func toIntroViewData() -> IntroViewData {
        return IntroViewData(
            recommendVersion: self.recommendVersion,
            minVersion: self.minVersion
        )
    }
}
