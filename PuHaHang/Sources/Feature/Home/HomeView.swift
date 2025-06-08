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
            
            List {
                ForEachStore(store.scope(state: \.items, action: \.items)) { store in
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
}

extension HomeView {
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
