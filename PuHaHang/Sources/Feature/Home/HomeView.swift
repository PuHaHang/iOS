//
//  HomeView.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    @Bindable var store: StoreOf<HomeReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            TitleBarView(titleIconName: store.titleIconName)
            
            if store.recipes.isEmpty {
                RecipeListEmptyView()
            } else {
                RecipeListSectionView(store: store)
            }
        }
    }
}

extension HomeView {
    private struct RecipeListSectionView: View {
        @Bindable var store: StoreOf<HomeReducer>
        
        var body: some View {
            List {
                ForEachStore(store.scope(state: \.recipes, action: \.recipes)) { store in
                    RecipeListItemView(store: store)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                }
                
                Color.clear
                    .frame(height: 120)
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(PlainListStyle())
            .scrollIndicators(.hidden)
        }
    }
    
    private struct TitleBarView: View {
        let titleIconName: String
        
        var body: some View {
            ZStack(alignment: .bottomLeading) {
                Color.white
                    .frame(height: 110)
                
                Image(titleIconName)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
            }
        }
    }
}
