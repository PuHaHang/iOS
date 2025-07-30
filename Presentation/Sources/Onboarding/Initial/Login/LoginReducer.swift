//
//  LoginReducer.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Foundation
import UIKit

@Reducer
struct LoginReducer {
    @ObservableState
    struct State {
        let titleText: String = "레시핏에 오신 것을 환영합니다!"
        let subTitleText: String = """
            유튜브, 쇼츠, 텍스트를
            간편하게 레시피로 바꿔보세요.
            """
        
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case didTapStartButton
        
        case path(StackActionOf<Path>)
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .didTapStartButton:
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
                
            case .path, .delegate:
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
