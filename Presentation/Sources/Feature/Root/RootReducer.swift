//
//  RootReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Entity
import Foundation
import UIKit

@Reducer
struct RootReducer {
    @Dependency(\.fetchRecipeDetailUseCase) var fetchRecipeDetailUseCase
    
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
        
        case navigateToRecipe(RecipeDetailVO)
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
                let recipeID = item.recipeID
                return reduceShowRecipeDetail(recipeID: recipeID)
                
            case .destination(.presented(.convert(.path(.element(_, action: .process(.delegate(.refresh))))))):
                return .send(.home(.refresh))
                
            case .destination(.dismiss):
                return .none
                
            case .tabBar, .home, .setting, .destination:
                return .none
                
            case .navigateToRecipe(let detail):
                return reduceNavigateToRecipe(&state, detail: detail)
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination.body
        }
    }
}

private extension RootReducer {
    func reduceShowRecipeDetail(recipeID: UUID) -> Effect<Action> {
        return .run { send in
            let result = await fetchRecipeDetailUseCase.execute(recipeID: recipeID)
            
            switch result {
            case .success(let detail):
                return await send(.navigateToRecipe(detail))
                
            case .failure(let error):
                print(">>> \(error)")
            }
        }
    }
    
    func reduceNavigateToRecipe(_ state: inout State, detail: RecipeDetailVO) -> Effect<Action> {
        let recipeState = RecipeReducer.State(recipe: detail)
        state.destination = .recipeDetail(recipeState)
        
        return .none
    }
}

extension RootReducer {
    @Reducer
    enum Destination {
        case convert(ConvertReducer)
        case recipeDetail(RecipeReducer)
    }
}
