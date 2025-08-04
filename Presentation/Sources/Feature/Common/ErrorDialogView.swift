//
//  ErrorDialogView.swift
//  Presentation
//
//  Created by PuHaHang on 1/20/25.
//

import SwiftUI

struct ErrorDialogView: View {
    let title: String
    let message: String
    let onBackAction: (() -> Void)?
    let backButtonText: String
    let showBackButton: Bool
    
    @Binding var isPresented: Bool
    
    private let backgroundDimColor = Color.black.opacity(0.2)
    
    init(
        title: String,
        message: String,
        isPresented: Binding<Bool>,
        onBackAction: (() -> Void)? = nil,
        backButtonText: String = "뒤로가기",
        showBackButton: Bool = true
    ) {
        self.title = title
        self.message = message
        self._isPresented = isPresented
        self.onBackAction = onBackAction
        self.backButtonText = backButtonText
        self.showBackButton = showBackButton
    }
    
    var body: some View {
        if isPresented {
            ZStack {
                backgroundDimColor
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 48, weight: .semibold))
                            .foregroundColor(.orange)
                        
                        VStack(spacing: 8) {
                            Text(title)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.center)
                            
                            Text(message)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                        }
                    }
                    
                    VStack(spacing: 12) {
                        if showBackButton {
                            Button(action: {
                                dismiss()
                                onBackAction?()
                            }) {
                                Text(backButtonText)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.primary)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(12)
                            }
                        }
                    }
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 4)
                )
                .padding(.horizontal, 40)
                .scaleEffect(isPresented ? 1.0 : 0.8)
                .opacity(isPresented ? 1.0 : 0.0)
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isPresented)
            }
            .zIndex(1000)
        }
    }
    
    private func dismiss() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isPresented = false
        }
    }
}

struct ErrorDialogModifier: ViewModifier {
    let title: String
    let message: String
    @Binding var isPresented: Bool
    let onBackAction: (() -> Void)?
    let backButtonText: String
    let showBackButton: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            ErrorDialogView(
                title: title,
                message: message,
                isPresented: $isPresented,
                onBackAction: onBackAction,
                backButtonText: backButtonText,
                showBackButton: showBackButton
            )
        }
    }
}

extension View {
    func errorDialog(
        title: String,
        message: String,
        isPresented: Binding<Bool>,
        onBackAction: (() -> Void)? = nil,
        backButtonText: String = "뒤로가기",
        showBackButton: Bool = true
    ) -> some View {
        self.modifier(
            ErrorDialogModifier(
                title: title,
                message: message,
                isPresented: isPresented,
                onBackAction: onBackAction,
                backButtonText: backButtonText,
                showBackButton: showBackButton
            )
        )
    }
}
