//
//  ServingInfoView.swift
//  PuHaHang
//
//  Created by 디해 on 6/10/25.
//

import SwiftUI

struct ServingInfoView: View {
    let servingText: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "person")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundStyle(AppColor.Text.serving)
            
            Text(servingText)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundStyle(AppColor.Text.serving)
                .lineLimit(1)
        }
    }
}
