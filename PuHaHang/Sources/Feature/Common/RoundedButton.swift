//
//  RoundedButton.swift
//  PuHaHang
//
//  Created by 디해 on 6/11/25.
//

import SwiftUI

struct RoundedButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(17)
                .background(isEnabled ? AppColor.main : AppColor.Component.disabledButton)
                .cornerRadius(30)
        }
        .frame(maxWidth: 300)
        .disabled(!isEnabled)
    }
}
