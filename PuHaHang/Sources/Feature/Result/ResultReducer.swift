//
//  ResultReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/17/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ResultReducer {
    @ObservableState
    struct State {
        let title: String
    }
    
    enum Action {
        case didTapHomeButton
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapHomeButton:
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
