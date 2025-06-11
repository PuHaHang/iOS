//
//  RecipeView.swift
//  PuHaHang
//
//  Created by 디해 on 6/10/25.
//

import ComposableArchitecture
import SwiftUI

struct RecipeView: View {
    @Bindable var store: StoreOf<RecipeReducer>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ZStack(alignment: .bottom) {
                RecipeContentView(store: store)
                
                RoundedButton(
                    title: "요리하기",
                    isEnabled: true
                ) {
                    store.send(.didTapCookingButton)
                }
                .padding(.bottom, 20)
            }
        } destination: { store in
            switch store.case {
            case .cooking(let store):
                CookingView(store: store)
            }
        }
    }
}

private extension RecipeView {
    struct RecipeContentView: View {
        let store: StoreOf<RecipeReducer>
        
        var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    RecipeImageContentView(
                        store: store,
                        action: {
                        store.send(.didTapContentButton)
                    })
                    .padding(.bottom, 20)
                    
                    RecipeOverviewView(
                        title: store.title,
                        serving: store.serving
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    
                    Color.black
                        .frame(height: 700)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    struct RecipeImageContentView: View {
        let store: StoreOf<RecipeReducer>
        let action: () -> Void
        
        var body: some View {
            ZStack(alignment: .bottomLeading) {
                Image(uiImage: store.thumbnail)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                
                OriginalContentButton(action: action)
                    .padding(15)
            }
        }
    }
    
    struct RecipeOverviewView: View {
        let title: String
        let serving: String
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.system(size: 20))
                    .foregroundStyle(AppColor.Text.main)
                    .fontWeight(.bold)
                
                Spacer()
                
                ServingInfoView(servingText: serving)
            }
        }
    }
}
