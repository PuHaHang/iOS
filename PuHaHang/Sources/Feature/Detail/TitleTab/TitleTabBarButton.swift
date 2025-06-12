//
//  TitleTabBarButton.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import SwiftUI

struct TitleTabBarButton: View {
    let item: TitleTabBarItem
    let action: () -> Void
    let isSelected: Bool
    let underlineNamespace: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                action()
            }
        }, label: {
            VStack {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(isSelected ? AppColor.main : .gray)
                    .padding(.bottom, 8)
                
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(AppColor.main)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                    } else {
                        Color.clear.frame(height: 2)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        })
    }
}
