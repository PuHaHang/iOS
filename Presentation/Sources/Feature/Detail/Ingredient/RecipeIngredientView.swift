//
//  RecipeIngredientView.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import ComposableArchitecture
import SwiftUI

struct RecipeIngredientView: View {
    @Bindable var store: StoreOf<RecipeIngredientReducer>
    
    var body: some View {
        VStack(spacing: 10) {
            ForEachStore(store.scope(state: \.ingredients, action: \.ingredients)) { store in
                IngredientListItemView(store: store)
            }
            
            Color.clear
                .frame(height: 90)
        }
        .padding(.horizontal, 10)
        .onAppear {
            store.send(.onAppear)
        }
    }
}
