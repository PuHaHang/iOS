//
//  TabBarView.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import SwiftUI

struct TabBarView: View {
    let store: StoreOf<TabReducer>
    
    var body: some View {
        ZStack(alignment: .top) {
            TabBarBackgroundView()
            
            HStack {
                Spacer()
                TabBarItemView(
                    tab: .home,
                    selectedTab: store.tab,
                    action: { store.send(.didTabItem(.home)) }
                )
                Spacer()
                Spacer().frame(width: 70)
                Spacer()
                TabBarItemView(
                    tab: .setting,
                    selectedTab: store.tab,
                    action: { store.send(.didTabItem(.setting)) }
                )
                Spacer()
            }
            .padding(.top, 15)
            
            TabPlusButton(action: { store.send(.didTabPlusButton) })
            .offset(y: -20)
        }
    }
}

extension TabBarView {
    private struct TabPlusButton: View {
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Image(systemName: "plus")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color.white)
                    .frame(width: 70, height: 70)
                    .background(AppColor.Component.plusButton)
                    .clipShape(Circle())
            }
        }
    }
    
    private struct TabBarBackgroundView: View {
        var body: some View {
            Rectangle()
                .fill(.white)
                .frame(height: 90)
                .shadow(
                    color: .black.opacity(0.1),
                    radius: 4,
                    x: 0,
                    y: -2
                )
        }
    }
}
