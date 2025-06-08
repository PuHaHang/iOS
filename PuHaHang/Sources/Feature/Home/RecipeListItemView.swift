//
//  RecipeListItemView.swift
//  PuHaHang
//
//  Created by 디해 on 6/8/25.
//

import ComposableArchitecture
import SwiftUI

struct RecipeListItemView: View {
    @Bindable var store: StoreOf<RecipeListItemReducer>
    
    var body: some View {
        HStack(spacing: 15) {
            Image(uiImage: store.thumbnail)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(store.title)
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .foregroundStyle(AppColor.Text.main)
                    .lineLimit(1)
                
                HStack(spacing: 5) {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(AppColor.Text.serving)
                    
                    Text(store.serving)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(AppColor.Text.serving)
                        .lineLimit(1)
                }
                
                Text(store.ingredients)
                    .font(.system(size: 14))
                    .foregroundStyle(AppColor.Text.ingredients)
                    .lineLimit(2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 0)
        )
        .onTapGesture {
            store.send(.didTapItem)
        }
    }
}
