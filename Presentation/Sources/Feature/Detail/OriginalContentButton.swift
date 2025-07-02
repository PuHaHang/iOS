//
//  OriginalContentButton.swift
//  PuHaHang
//
//  Created by 디해 on 6/10/25.
//

import SwiftUI

struct OriginalContentButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                
                Text("원본 보기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.5))
            )
        }
        .buttonStyle(.plain)
    }
}
