//
//  RecipeView.swift
//  PuHaHang
//
//  Created by 디해 on 6/10/25.
//

import ComposableArchitecture
import Kingfisher
import Shared
import SwiftUI

struct RecipeView: View {
    @Bindable var store: StoreOf<RecipeReducer>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ZStack(alignment: .bottom) {
                RecipeContentView(store: store)
                
                RoundedButton(
                    title: LocalizationHelper.detailCooking,
                    isEnabled: true
                ) {
                    store.send(.didTapCookingButton)
                }
                .padding(.bottom, 20)
            }
        } destination: { store in
            switch store.case {
            case .cookingOnboarding(let store):
                CookingOnboardingIntroView(store: store)
            case .voicePermission(let store):
                VoicePermissionView(store: store)
            case .cookingIntroduction(let store):
                CookingIntroductionView(store: store)
            case .completion(let store):
                CookingCompletionView(store: store)
            case .cooking(let store):
                CookingView(store: store)
            case .result(let store):
                ResultView(store: store)
            }
        }
        .onAppear {
            store.send(.onAppear)
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
                        title: store.recipeViewData.title,
                        serving: store.recipeViewData.serving
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                    
                    TitleTabView(store: store.scope(state: \.titleTab, action: \.titleTab))
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
                KFImage.url(store.recipeViewData.thumbnail)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                
                OriginalContentButton(action: action)
                    .padding(15)
                    .disabled(!store.recipeViewData.reference.hasExternalLink)
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
