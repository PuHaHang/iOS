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
            
            switch store.listState {
            case .idle:
                Spacer()
            case .loaded:
                RecipeListSectionView(store: store)
            case .empty:
                RecipeListEmptyView()
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
        .onDisappear {
            store.send(.clearError)
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
        .errorDialog(
            title: store.errorState.dialogTitle,
            message: store.errorState.dialogMessage,
            isPresented: .init(
                get: { store.errorState.showDialog },
                set: { _ in store.send(.clearError) }
            ),
            onBackAction: store.errorState.showBackButton ? {
                store.send(.clearError)
            } : nil,
            showBackButton: store.errorState.showBackButton
        )
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
                
                FooterSentinelView(
                    onAppear: { store.send(.scroll) }
                )
            }
            .listStyle(PlainListStyle())
            .scrollIndicators(.hidden)
        }
    }
    
    
    private struct FooterSentinelView: View {
        let onAppear: () -> Void
        var body: some View {
            Color.clear
                .frame(height: 120)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .onAppear(perform: onAppear)
        }
    }
    
    private struct TitleBarView: View {
        let titleIconName: String
        
        var body: some View {
            ZStack(alignment: .bottomLeading) {
                Color.white
                    .frame(height: 110)
                
                Image(titleIconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65)
                    .padding(.leading, 15)
                    .padding(.bottom, 15)
            }
        }
    }
}
