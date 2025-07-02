//
//  ConvertReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/8/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ConvertReducer {
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State: Equatable {
        let highlightedInfoText: String = "변환하고 싶은 레시피"
        let infoText: String = "를\n입력해주세요"
        let warningText: String = """
                                  유튜브 영상, 숏츠 URL, 레시피 텍스트만 변환 가능해요.
                                  설명이나 캡션이 자세할수록 좋아요.
                                  """
        let warningIconName: String = "warning_icon"
        let textPlaceholder: String = "내용을 입력하세요."
        let buttonText: String = "변환하기"
        
        var recipeSource: String = ""
        var isGenerateButtonEnabled: Bool {
            !recipeSource.isEmpty
        }
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case didTapConvertButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .didTapConvertButton:
                return .concatenate(
                    .send(.delegate(.generateRecipe(state.recipeSource))),
                    .run { _ in await dismiss() }
                )
                
            case .binding:
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}

extension ConvertReducer.Action {
    enum Delegate: Equatable {
        case generateRecipe(String)
    }
}
