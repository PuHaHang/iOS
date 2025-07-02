//
//  TabBarItemView.swift
//  PuHaHang
//
//  Created by 디해 on 6/5/25.
//

import SwiftUI

extension TabBarView {
    struct TabBarItemView: View {
        let tab: Tab
        let selectedTab: Tab
        let action: () -> Void
        
        var body: some View {
            Image(systemName: tab.icon)
                .font(.system(size: 24))
                .foregroundColor(
                    selectedTab == tab ? AppColor.TabBar.activeButton : AppColor.TabBar.inactiveButton
                )
                .onTapGesture { action() }
        }
    }
}
