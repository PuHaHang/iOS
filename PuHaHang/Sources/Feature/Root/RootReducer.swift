//
//  RootReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation
import UIKit

@Reducer
struct RootReducer {
    @ObservableState
    struct State {
        @Presents var destination: Destination.State?
        
        var tabBar = TabReducer.State()
        var home = HomeReducer.State()
        var setting = SettingReducer.State()
    }
    
    enum Action {
        case destination(PresentationAction<Destination.Action>)
        
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
                state.destination = .convert(ConvertReducer.State())
                return .none
                
            case .home(.delegate(.showRecipeDetail(let item))):
                state.destination = .recipeDetail(
                    RecipeReducer.State(
                        recipeID: item.recipeID,
                        title: item.title,
                        thumbnail: item.thumbnail,
                        serving: item.serving,
                        hasURL: true,
                        steps: [],
                        ingredients: []
                    )
                )
                return .none
                
            case .destination(.presented(.convert(.delegate(.generateRecipe(let recipeSource))))):
                print(">>> \(recipeSource)")
                return .none
                
            case .tabBar, .home, .setting, .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination.body
        }
    }
}

extension RootReducer {
    @Reducer
    enum Destination {
        case convert(ConvertReducer)
        case recipeDetail(RecipeReducer)
    }
}
