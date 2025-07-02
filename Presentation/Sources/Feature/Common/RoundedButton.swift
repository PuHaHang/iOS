//
//  RoundedButton.swift
//  PuHaHang
//
//  Created by 디해 on 6/11/25.
//

import SwiftUI

struct RoundedButton: View {
    private enum Content {
        case title(String)
        case systemImage(String)
    }

    private let content: Content
    private let isEnabled: Bool
    private let action: () -> Void

    init(title: String, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.content = .title(title)
        self.isEnabled = isEnabled
        self.action = action
    }

    init(systemImageName: String, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.content = .systemImage(systemImageName)
        self.isEnabled = isEnabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Group {
                switch content {
                case .title(let title):
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                case .systemImage(let name):
                    Image(systemName: name)
                        .font(.system(size: 20, weight: .semibold))
                }
            }
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
