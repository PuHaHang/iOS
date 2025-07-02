//
//  TitleTabView.swift
//  PuHaHang
//
//  Created by 디해 on 6/10/25.
//

import ComposableArchitecture
import SwiftUI

struct TitleTabView: View {
    @Bindable var store: StoreOf<TitleTabReducer>
    
    @Namespace private var underlineNamespace
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(store.tabBarItems, id: \.self) { item in
                    TitleTabBarButton(
                        item: item,
                        action: { store.send(.didTabItem(item)) },
                        isSelected: store.selectedItem == item,
                        underlineNamespace: underlineNamespace
                    )
                }
            }
            .background(Color.white)
            
            Divider()
                .padding(.bottom, 20)
            
            Group {
                switch store.selectedItem {
                case .steps:
                    RecipeStepView(store: store.scope(state: \.recipeStep, action: \.recipeStep))
                    
                case .ingredients:
                    RecipeIngredientView(store: store.scope(state: \.recipeIngredient, action: \.recipeIngredient))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
