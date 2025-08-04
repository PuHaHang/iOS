//
//  ErrorToastView.swift
//  Presentation
//
//  Created by PuHaHang on 1/20/25.
//

import SwiftUI

struct ErrorToastView: View {
    @Binding var isVisible: Bool
    
    let message: String
    let duration: TimeInterval
    
    @State private var animationOffset: CGFloat = 100
    @State private var animationOpacity: Double = 0
    
    init(
        message: String,
        isVisible: Binding<Bool>,
        duration: TimeInterval = 3.0
    ) {
        self.message = message
        self._isVisible = isVisible
        self.duration = duration
    }
    
    var body: some View {
        if isVisible {
            HStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.orange)
                
                Text(message)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
                Spacer()
                
                Button(action: {
                    dismissToast()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal, 20)
            .offset(y: animationOffset)
            .opacity(animationOpacity)
            .onTapGesture {
                dismissToast()
            }
            .onAppear {
                showToast()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    if isVisible {
                        dismissToast()
                    }
                }
            }
            .allowsHitTesting(true)
            .zIndex(999)
        }
    }
    
    private func showToast() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0)) {
            animationOffset = 0
            animationOpacity = 1.0
        }
    }
    
    private func dismissToast() {
        withAnimation(.easeInOut(duration: 0.4)) {
            animationOffset = 100
            animationOpacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            isVisible = false
            animationOffset = 100
            animationOpacity = 0
        }
    }
}

struct ErrorToastModifier: ViewModifier {
    let message: String
    @Binding var isVisible: Bool
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack {
                Spacer()
                
                ErrorToastView(
                    message: message,
                    isVisible: $isVisible,
                    duration: duration
                )
                .padding(.bottom, 120)
            }
        }
    }
}

extension View {
    func errorToast(
        message: String,
        isVisible: Binding<Bool>,
        duration: TimeInterval = 3.0
    ) -> some View {
        self.modifier(
            ErrorToastModifier(
                message: message,
                isVisible: isVisible,
                duration: duration
            )
        )
    }
}
