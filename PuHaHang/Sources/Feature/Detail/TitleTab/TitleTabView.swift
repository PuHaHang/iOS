//
//  TitleTabView.swift
//  PuHaHang
//
//  Created by 디해 on 6/10/25.
//

import ComposableArchitecture
import SwiftUI

struct TitleTabView: View {
    @Bindable var store: StoreOf<TitleTabReducer>
    
    @Namespace private var underlineNamespace
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(store.tabBarItems, id: \.self) { item in
                    TitleTabBarButton(
                        item: item,
                        action: { store.send(.didTabItem(item)) },
                        isSelected: store.selectedItem == item,
                        underlineNamespace: underlineNamespace
                    )
                }
            }
            .background(Color.white)
            
            Divider()
            
            Group {
                switch store.selectedItem {
                case .steps:
                    Color.red
                        .frame(height: 700)
                    
                case .ingredients:
                    Color.blue
                        .frame(height: 700)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
