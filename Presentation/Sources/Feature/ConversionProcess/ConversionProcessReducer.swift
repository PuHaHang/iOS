//
//  ConversionProcessReducer.swift
//  Presentation
//
//  Created by 디해 on 7/12/25.
//

import ComposableArchitecture
import Entity
import Foundation
import UIKit

@Reducer
struct ConversionProcessReducer {
    @Dependency(\.fetchConvertedRecipeIDUseCase) var fetchConvertedRecipeIDUseCase
    @Dependency(\.fetchRecipeDetailUseCase) var fetchRecipeDetailUseCase
    
    struct State: Equatable {
        let recipeSource: String
        var recipeConversionID: UUID?
    }
    
    enum Action: Equatable {
        case onAppear
        case recipeConversionResponse(UUID)
        
        case startPolling
        case stopPolling
        case pollTick
        case pollResponse(RecipePreviewViewData)
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return reduceOnAppear(&state)
                
            case .recipeConversionResponse(let uuid):
                return reduceRecipeConversionResponse(&state, id: uuid)
                
            case .startPolling:
                return reduceStartPolling()
                
            case .stopPolling:
                return .cancel(id: CancelID.polling)
                
            case .pollTick:
                return reducePollTick(state)
                
            case .pollResponse(let preview):
                return reducePollResponse(preview: preview)
                
            case .delegate:
                return .none
            }
        }
    }
}

private extension ConversionProcessReducer {
    func reduceOnAppear(_ state: inout State) -> Effect<Action> {
        let source = state.recipeSource
        
        return .run { send in
            let result = await fetchConvertedRecipeIDUseCase.execute(source)
            switch result {
            case .success(let uuid):
                await send(.delegate(.refresh))
                await send(.recipeConversionResponse(uuid))
            case .failure(let error):
                print(">>> \(error)")
            }
        }
    }
    
    func reduceRecipeConversionResponse(_ state: inout State, id: UUID) -> Effect<Action> {
        state.recipeConversionID = id
        return .send(.startPolling)
    }
    
    func reduceStartPolling() -> Effect<Action> {
        return .run { send in
            for await _ in Timer
                .publish(every: 4, on: .main, in: .common)
                .autoconnect()
                .values {
                await send(.pollTick)
            }
        }
        .cancellable(id: CancelID.polling)
    }
    
    func reducePollTick(_ state: State) -> Effect<Action> {
        guard let id = state.recipeConversionID else { return .none }
        
        return .run { send in
            let result = await fetchRecipeDetailUseCase.execute(recipeID: id)
            switch result {
            case .success(let detail):
                let preview = detail.toRecipePreviewViewData()
                await send(.pollResponse(preview))
                
            case .failure(let error):
                print(">>> \(error)")
            }
        }
    }
    
    func reducePollResponse(preview: RecipePreviewViewData) -> Effect<Action> {
        if preview.state == .completed {
            return .concatenate(
                .send(.stopPolling),
                .send(.delegate(.navigateToResult(preview)))
            )
        }
        
        return .none
    }
}

private extension RecipeDetailVO {
    func toRecipePreviewViewData() -> RecipePreviewViewData {
        return RecipePreviewViewData(
            recipeID: self.recipeID,
            thumbnail: UIImage(),
            title: self.title,
            serving: "\(self.serving)인분",
            steps: self.stages.map { $0.toStepViewData() },
            state: self.state.toRecipeStateViewData()
        )
    }
}

private extension RecipeStateVO {
    func toRecipeStateViewData() -> RecipeStateViewData {
        switch self {
        case .inProgress:
            return .inProgress
        case .completed:
            return .completed
        case .unknown:
            return .unknown
        }
    }
}

extension ConversionProcessReducer {
    enum CancelID {
        case polling
    }
    
    enum Delegate: Equatable {
        case refresh
        case navigateToResult(RecipePreviewViewData)
    }
}
