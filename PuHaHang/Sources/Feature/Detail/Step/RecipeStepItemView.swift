//
//  RecipeStepItemView.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import SwiftUI

struct RecipeStepItemView: View {
    let step: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(step)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(AppColor.Text.highlight)
            
            Text(content)
                .font(.system(size: 15))
        }
        .padding(25)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 4)
        )
        .padding(4)
    }
}
