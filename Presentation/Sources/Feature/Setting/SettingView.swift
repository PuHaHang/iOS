//
//  SettingView.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Shared
import SwiftUI

struct SettingView: View {
    @Bindable var store: StoreOf<SettingReducer>
    
    var body: some View {
        NavigationView {
            List {
                SettingRowView(
                    title: LocalizationHelper.settingsInstagramTitle,
                    subtitle: LocalizationHelper.settingsInstagramSubtitle,
                    iconName: "camera"
                ) {
                    store.send(.visitInstagram)
                }
            }
        }
    }
}

struct SettingRowView: View {
    let title: String
    let subtitle: String
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: iconName)
                    .foregroundColor(AppColor.main)
                    .frame(width: 20, height: 20)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(AppColor.Text.main)
                    
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(AppColor.Text.information)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(AppColor.Text.information)
            }
            .padding(.vertical, 8)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
