//
//  TabReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation
import Logger

@Reducer
struct TabReducer {
    @Dependency(\.logger) var logger
    
    @ObservableState
    struct State: Equatable {
        var tab: Tab = .home
    }
    
    enum Action: Equatable {
        case didTabPlusButton
        case didTabItem(Tab)
        case tabChanged(Tab)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTabItem(let tab):
                state.tab = tab
                switch tab {
                case .home:
                    logger.track(.homeTabButton)
                case .setting:
                    logger.track(.settingTabButton)
                }
                return .none
                
            case .didTabPlusButton:
                logger.track(.plusTabButton)
                return .none
                
            case .tabChanged:
                return .none
            }
        }
    }
}
