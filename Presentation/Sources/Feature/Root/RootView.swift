//
//  RootView.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    @Bindable var store: StoreOf<RootReducer>
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch store.tabBar.tab {
                case .home:
                    HomeView(store: store.scope(state: \.home, action: \.home))
                case .setting:
                    SettingView(store: store.scope(state: \.setting, action: \.setting))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            TabBarView(store: store.scope(state: \.tabBar, action: \.tabBar))
        }
        .ignoresSafeArea()
        .sheet(
            item: $store.scope(state: \.destination?.convert, action: \.destination.convert),
            content: { store in
                ConvertView(store: store)
            })
        .sheet(item: $store.scope(state: \.destination?.recipeDetail, action: \.destination.recipeDetail)) { store in
            RecipeView(store: store)
        }
    }
}
