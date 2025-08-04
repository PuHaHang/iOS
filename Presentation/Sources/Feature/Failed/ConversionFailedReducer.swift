//
//  FailedReducer.swift
//  Presentation
//
//  Created by 디해 on 8/1/25.
//

import ComposableArchitecture
import Foundation
import Logger

@Reducer
struct ConversionFailedReducer {
    @Dependency(\.logger) var logger
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case onAppear
        case didTapHomeButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                logger.track(.failedScreen)
                return .none
                
            case .didTapHomeButton:
                logger.track(.conversionFailedConfirmButton)
                return .send(.delegate(.didRequestDismiss))
                
            case .delegate:
                return .none
            }
        }
    }
}

extension  ConversionFailedReducer {
    enum Delegate {
        case didRequestDismiss
    }
}
