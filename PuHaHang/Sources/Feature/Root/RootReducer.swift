//
//  RootReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct RootReducer {
    @ObservableState
    struct State {
        @Presents var convert: ConvertReducer.State?
        
        var tabBar = TabReducer.State()
        var home = HomeReducer.State()
        var setting = SettingReducer.State()
    }
    
    enum Action {
        case convert(PresentationAction<ConvertReducer.Action>)
        
        case tabBar(TabReducer.Action)
        case home(HomeReducer.Action)
        case setting(SettingReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.tabBar, action: \.tabBar) {
            TabReducer()
        }
        
        Scope(state: \.home, action: \.home) {
            HomeReducer()
        }
        
        Scope(state: \.setting, action: \.setting) {
            SettingReducer()
        }
        
        Reduce { state, action in
            switch action {
            case .tabBar(.didTabPlusButton):
                state.convert = ConvertReducer.State()
                return .none
                
            case .convert(.presented(.delegate(.generateRecipe(let recipeSource)))):
                print(">>> \(recipeSource)")
                return .none
                
            case .tabBar, .home, .setting, .convert:
                return .none
            }
        }
        .ifLet(\.$convert, action: \.convert) {
            ConvertReducer()
        }
    }
}
