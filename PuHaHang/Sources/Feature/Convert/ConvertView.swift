//
//  ConvertView.swift
//  PuHaHang
//
//  Created by 디해 on 6/8/25.
//

import ComposableArchitecture
import SwiftUI

struct ConvertView: View {
    @Bindable var store: StoreOf<ConvertReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            HighlightedInfoTextView(
                highlightedText: store.highlightedInfoText,
                normalText: store.infoText
            )
            
            Image(store.warningIconName)
                .padding(.bottom, 10)
            
            WarningTextView(text: store.warningText)
            
            RoundedInputTextField(
                placeholder: store.textPlaceholder,
                text: $store.recipeSource
            )
            
            RoundedButton(
                title: store.buttonText,
                isEnabled: store.isGenerateButtonEnabled,
                action: {
                    store.send(.didTapConvertButton)
                })
            
            Spacer()
        }
    }
}

private extension ConvertView {
    struct HighlightedInfoTextView: View {
        let highlightedText: String
        let normalText: String

        var body: some View {
            Group {
                Text(highlightedText)
                    .foregroundStyle(AppColor.main)
                + Text(normalText)
                    .foregroundStyle(AppColor.Text.main)
            }
            .fontWeight(.bold)
            .font(.system(size: 23))
            .multilineTextAlignment(.center)
            .padding(.top, 70)
            .padding(.bottom, 27)
        }
    }
    
    struct WarningTextView: View {
        let text: String

        var body: some View {
            Text(text)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundStyle(AppColor.Text.information)
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
        }
    }
    struct RoundedInputTextField: View {
        let placeholder: String
        @Binding var text: String

        var body: some View {
            TextField(placeholder, text: $text)
                .font(.system(size: 16, weight: .medium))
                .padding(20)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 25)
                .padding(.bottom, 25)
        }
    }
    
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
            .frame(maxWidth: 200)
            .disabled(!isEnabled)
        }
    }
}
