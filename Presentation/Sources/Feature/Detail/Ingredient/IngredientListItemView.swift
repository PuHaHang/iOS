//
//  RecipeIngredientItemView.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import ComposableArchitecture
import SwiftUI

struct IngredientListItemView: View {
    @Bindable var store: StoreOf<IngredientItemReducer>
    
    var body: some View {
        HStack {
            Image(systemName: store.isChecked ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(store.isChecked ? AppColor.IngredientTodo.checkedIcon : AppColor.IngredientTodo.uncheckedIcon)
            
            Text(store.name)
                .font(.system(size: 15))
                .foregroundStyle(store.isChecked ? AppColor.IngredientTodo.checkedText : AppColor.IngredientTodo.uncheckedText)
                .strikethrough(store.isChecked, color: AppColor.IngredientTodo.checkedText)
            
            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(AppColor.IngredientTodo.background)
        )
        .onTapGesture {
            store.send(.didTapItem(store.id))
        }
        .errorToast(
            message: store.errorState.toastMessage,
            isVisible: .init(
                get: { store.errorState.showToast },
                set: { newValue in
                    if !newValue {
                        store.send(.clearError)
                    }
                }
            ),
            duration: store.errorState.toastDuration
        )
    }
}
