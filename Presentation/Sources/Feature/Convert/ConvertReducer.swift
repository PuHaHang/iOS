//
//  ConvertReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/8/25.
//

import ComposableArchitecture
import Foundation
import Shared

@Reducer
struct ConvertReducer {
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State: Equatable {
        let highlightedInfoText: String = LocalizationHelper.convertHighlightedInfo
        let infoText: String = LocalizationHelper.convertInfo
        let warningText: String = LocalizationHelper.convertWarning
        let warningIconName: String = "warning_icon"
        let textPlaceholder: String = LocalizationHelper.convertPlaceholder
        let buttonText: String = LocalizationHelper.convertButton
        
        var recipeSource: String = ""
        var isGenerateButtonEnabled: Bool {
            !recipeSource.isEmpty
        }
        
        var path = StackState<Path.State>()
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case didTapConvertButton
        
        case path(StackActionOf<Path>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .didTapConvertButton:
                let source = state.recipeSource
                state.path.append(.process(.init(recipeSource: source)))
                return .none
                
            case .path(.element(_, action: .process(.delegate(.navigateToResult(let preview))))):
                state.path.append(.result(.init(recipePreviewViewData: preview)))
                return .none
                
            case .path(.element(_, action: .result(.delegate(.didRequestDismiss)))):
                return .run { _ in await dismiss() }
                
            case .binding:
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path.body
        }
    }
}

extension ConvertReducer {
    @Reducer(state: .equatable, action: .equatable)
    enum Path {
        case process(ConversionProcessReducer)
        case result(ConversionResultReducer)
    }
}
