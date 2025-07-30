//
//  SplashReducer.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import ComposableArchitecture
import Foundation
import Dependencies
import Domain
import Entity

@Reducer
public struct SplashReducer {
    @Dependency(\.introUseCase) var introUseCase
    @Dependency(\.launchOnboardingCheckUseCase) var launchOnboardingCheckUseCase
    
    public init() { }
    
    @ObservableState
    public struct State {
        let appTitle: String = "내 손 안의 요리 도우미"
        let appIconName: String = "splash_icon"
        var introState: IntroStateViewData = .idle
        
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case introResponse(Result<IntroViewData, Error>)
    }
    
    public var body: some ReducerOf<Self> {
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
            let introResult = await introUseCase.execute()
            
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
            let isFirstLaunch = launchOnboardingCheckUseCase.execute()
            if isFirstLaunch {
                state.introState = .onboarding
            } else {
                state.introState = .success
            }
            
        case .failure(let error):
            state.introState = .failure(error)
        }
        
        return .none
    }
}

private extension IntroVO {
    func toIntroViewData() -> IntroViewData {
        return IntroViewData(
            recommendVersion: self.recommendVersion,
            minVersion: self.minVersion
        )
    }
}
