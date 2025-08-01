//
//  ResultReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/17/25.
//

import ComposableArchitecture
import Foundation
import Logger

@Reducer
struct ResultReducer {
    @Dependency(\.logger) var logger
    
    @ObservableState
    struct State {
        let title: String
    }
    
    enum Action {
        case onAppear
        case didTapHomeButton
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                logger.track(.resultScreen)
                return .none
                
            case .didTapHomeButton:
                logger.track(.resultHomeButton)
                return .send(.delegate(.didRequestDismiss))
                
            case .delegate:
                return .none
            }
        }
    }
}

extension ResultReducer.Action {
    enum Delegate: Equatable {
        case didRequestDismiss
    }
}
