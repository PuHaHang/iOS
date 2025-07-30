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
import Login

@Reducer
public struct SplashReducer {
    @Dependency(\.fetchUILanguageUseCase) var fetchLanguageUseCase
    @Dependency(\.setUILanguageUseCase) var setUILanguageUseCase
    @Dependency(\.localeProvider) var localeProvider
    @Dependency(\.loginManager) var loginManager
    @Dependency(\.introUseCase) var introUseCase
    @Dependency(\.launchOnboardingCheckUseCase) var launchOnboardingCheckUseCase
    
    public init() { }
    
    @ObservableState
    public struct State {
        var appTitle: String = ""
        let appIconName: String = "splash_icon"
        var introState: IntroStateViewData = .idle
        
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case loadIntro
        case introResponse(Result<IntroViewData, Error>)
        case initializeLanguage
        case configureWithLanguage(String)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return reduceOnAppear()
                
            case .loadIntro:
                return .run { send in
                    let introResult = await introUseCase.execute()
                    
                    switch introResult {
                    case .success(let intro):
                        await send(.introResponse(.success(intro.toIntroViewData())))
                    case .failure(let error):
                        await send(.introResponse(.failure(error)))
                    }
                }
                
            case .initializeLanguage:
                let deviceLanguage = localeProvider.getCurrentLanguage()
                setUILanguageUseCase.execute(deviceLanguage)
                return .send(.configureWithLanguage(deviceLanguage))
                
            case .configureWithLanguage(let language):
                state.appTitle = "내 손 안의 요리 도우미"
                return .none
                
            case .introResponse(let result):
                return reduceIntroResponse(&state, result: result)
            }
        }
    }
}

private extension SplashReducer {
    func reduceOnAppear() -> Effect<Action> {
        let language = fetchLanguageUseCase.execute()
        
        guard let language else {
            return .concatenate(
                .send(.initializeLanguage),
                .send(.loadIntro)
            )
        }
        
        return .concatenate(
            .send(.configureWithLanguage(language)),
            .send(.loadIntro)
        )
    }
    
    func reduceIntroResponse(
        _ state: inout SplashReducer.State,
        result: Result<IntroViewData, Error>
    ) -> Effect<Action> {
        switch result {
        case .success(let data):
            let isFirstLaunch = launchOnboardingCheckUseCase.execute()
            if isFirstLaunch {
                loginManager.deleteLocalToken()
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
