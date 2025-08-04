//
//  RecipeListItemView.swift
//  PuHaHang
//
//  Created by 디해 on 6/8/25.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI

struct RecipeListItemView: View {
    @Bindable var store: StoreOf<RecipeListItemReducer>
    
    var body: some View {
        Group {
            if store.item.state == .completed {
                RecipeListItemContentView(store: store)
            } else if store.item.state == .failed {
                RecipeListItemFailedView(
                    title: "레시피 변환 실패",
                    subTitle: "링크를 다시 확인하거나\n삭제해 주세요.",
                    onDelete: {
                        store.send(.didTapDeleteButton)
                    }
                )
            } else {
                RecipeListItemSkeletonView()
            }
        }
    }
}

private struct RecipeListItemContentView: View {
    let store: StoreOf<RecipeListItemReducer>
    
    var body: some View {
        HStack(spacing: 15) {
            KFImage.url(store.item.thumbnail)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(store.item.title)
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .foregroundStyle(AppColor.Text.main)
                    .lineLimit(1)
                
                ServingInfoView(servingText: store.item.serving)
                
                Text(store.item.ingredients)
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
            store.send(.didTapItem(store.item))
        }
    }
}

private struct RecipeListItemSkeletonView: View {
    var body: some View {
        HStack(spacing: 15) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.3))
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.gray.opacity(0.3))
                    .frame(width: 120, height: 18)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(.gray.opacity(0.3))
                    .frame(width: 60, height: 14)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(.gray.opacity(0.3))
                    .frame(height: 14)
                    .padding(.trailing, 50)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(.gray.opacity(0.3))
                    .frame(height: 14)
                    .padding(.trailing, 80)
            }
        }
        .redacted(reason: .placeholder)
        .shimmering()
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 0)
        )
    }
}

private struct RecipeListItemFailedView: View {
    let title: String
    let subTitle: String
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            RoundedRectangle(cornerRadius: 10)
                .fill(AppColor.Component.warningBackground)
                .overlay(
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.orange)
                )
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                    .lineLimit(1)
                
                Text(subTitle)
                    .font(.system(size: 14))
                    .foregroundStyle(AppColor.Text.information)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.gray)
            }
            .buttonStyle(.borderless)
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 0)
        )
    }
}
