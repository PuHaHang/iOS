//
//  LoginReducer.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Foundation
import Login
import LocaleProvider
import Shared
import UIKit
import Logger

@Reducer
struct LoginReducer {
    @Dependency(\.localeProvider) var localeProvider
    @Dependency(\.loginManager) var loginManager
    @Dependency(\.logger) var logger
    
    @ObservableState
    struct State {
        let titleText: String = LocalizationHelper.onboardingLoginWelcome
        let subTitleText: String = LocalizationHelper.onboardingLoginSubtitle
        
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case onAppear
        case didTapStartButton
        case createGuest
        case navigateToIntroduction
        case didAuthenticate(String)
        
        case path(StackActionOf<Path>)
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                logger.track(.onboardingLoginScreen)
                return .none
                
            case .didTapStartButton:
                logger.track(.onboardingLoginStartButton)
                let token = loginManager.loadLocalToken()
                guard let token else { return .send(.createGuest) }
                
                return .send(.didAuthenticate(token))
                
            case .createGuest:
                let region = localeProvider.getCurrentRegion()
                return .run { send in
                    do {
                        let token = try await loginManager.createGuestToken(region: region)
                        loginManager.saveLocalToken(token)
                        await send(.didAuthenticate(token))
                    } catch {
                        print(">>> \(error)")
                    }
                }
                
            case .didAuthenticate(let token):
                Task {
                    let fcmToken = try await loginManager.loadFCMToken()
                    try await loginManager.update(fcmToken: fcmToken, for: token)
                }
                
                return .send(.navigateToIntroduction)
                
            case .navigateToIntroduction:
                state.path.append(.introduction(.init()))
                return .none
                
            case .path(.element(id: _, action: .introduction(.delegate(.navigateToConversionExample)))):
                state.path.append(.example(.init()))
                return .none
                
            case .path(.element(id: _, action: .example(.delegate(.navigateToConversionProcess)))):
                state.path.append(.process(.init()))
                return .none
                
            case .path(.element(id: _, action: .process(.delegate(.navigateToConversionResult(let url))))):
                state.path.append(.result(.init(imageURL: url)))
                return .none
                
            case .path(.element(id: _, action: .result(.delegate(.didRequestDismiss)))):
                return .send(.delegate(.didRequestDismiss))
                
            case .path,
                    .delegate:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path.body
        }
    }
}

extension LoginReducer {
    @Reducer
    enum Path {
        case introduction(IntroductionReducer)
        case example(ConversionExampleReducer)
        case process(OnboardingConversionReducer)
        case result(OnboardingResultReducer)
    }
    
    enum Delegate {
        case didRequestDismiss
    }
}
