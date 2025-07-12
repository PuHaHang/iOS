//
//  RecipeReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/10/25.
//

import ComposableArchitecture
import Foundation
import Entity
import UIKit

@Reducer
struct RecipeReducer {
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State {
        let recipeViewData: RecipeViewData
        
        var path = StackState<Path.State>()
        var titleTab: TitleTabReducer.State
        
        init(recipe: RecipeDetailVO) {
            let recipeViewData = recipe.toRecipeViewData()
            self.recipeViewData = recipeViewData
            self.titleTab = TitleTabReducer.State(
                steps: recipeViewData.steps,
                ingredients: recipeViewData.ingredients
            )
        }
    }
    
    enum Action {
        case didTapContentButton
        case didTapCookingButton
        
        case path(StackActionOf<Path>)
        case titleTab(TitleTabReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.titleTab, action: \.titleTab) {
            TitleTabReducer()
        }
        
        Reduce { state, action in
            switch action {
            case .path(.element(_, .cooking(.delegate(.navigateToResult)))):
                return reduceNavigateToResult(&state)
                
            case .path(.element(_, .result(.delegate(.didRequestDismiss)))):
                return .run { _ in
                    await dismiss()
                }
                
            case .didTapContentButton:
                return reduceDidTapContentButton(state)
                
            case .didTapCookingButton:
                return reduceDidTapCookingButton(&state)
                
            case .path, .titleTab:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path.body
        }
    }
}

private extension RecipeReducer {
    func reduceNavigateToResult(_ state: inout State) -> Effect<Action> {
        let title = state.recipeViewData.title
        let resultState = ResultReducer.State(title: title)
        state.path.append(.result(resultState))
        return .none
    }
    
    func reduceDidTapCookingButton(_ state: inout State) -> Effect<Action> {
        let title = state.recipeViewData.title
        let steps = state.recipeViewData.steps
        let cookingState = CookingReducer.State(
            title: title,
            steps: steps,
            reference: state.recipeViewData.reference
        )
        state.path.append(.cooking(cookingState))
        return .none
    }
    
    func reduceDidTapContentButton(_ state: State) -> Effect<Action> {
        guard let externalLink = state.recipeViewData.reference.externalLink else { return .none }
        
        UIApplication.shared.open(
            externalLink,
            options: [:],
            completionHandler: nil
        )
        
        return .none
    }
}

private extension RecipeDetailVO {
    func toRecipeViewData() -> RecipeViewData {
        return RecipeViewData(
            recipeID: self.recipeID,
            title: self.title,
            thumbnail: UIImage(),
            serving: "\(self.serving)인분",
            reference: self.reference.toReferenceViewData(),
            steps: self.stages.map { $0.toStepViewData() },
            ingredients: self.ingredients.map { $0.toIngredientViewData() }
        )
    }
}

private extension ReferenceVO {
    func toReferenceViewData() -> ReferenceViewData {
        switch self {
        case .youtube(let url):
            return .youtube(url)
            
        case .shorts(let url):
            return .shorts(url)
            
        case .text(let content):
            return .text(content)
            
        case .unknown:
            return .unknown
        }
    }
}

private extension ReferenceVO {
    var urlToOpen: URL? {
        switch self {
        case .youtube(let url):
            return url
        case .shorts(let url):
            return url
        case .text:
            return nil
        case .unknown:
            return nil
        }
    }
}

extension StageVO {
    func toStepViewData() -> RecipeStepViewData {
        let startTimeMeasurement = Measurement(
            value: self.timeline.startTime,
            unit: UnitDuration.seconds
        )
        let endTimeMeasurement = Measurement(
            value: self.timeline.endTime,
            unit: UnitDuration.seconds
        )
        let timeline = TimeLineViewData(
            startTime: startTimeMeasurement,
            endTime: endTimeMeasurement
        )
        
        return RecipeStepViewData(
            id: UUID(),
            stepTitle: "STEP\(self.step)",
            stepContent: self.instruction,
            timeline: timeline
        )
    }
}

private extension IngredientVO {
    func toIngredientViewData() -> IngredientViewData {
        return IngredientViewData(
            id: UUID(),
            ingredient: "\(self.name) \(self.amount)",
            isChecked: false
        )
    }
}

extension RecipeReducer {
    @Reducer
    enum Path {
        case cooking(CookingReducer)
        case result(ResultReducer)
    }
}
