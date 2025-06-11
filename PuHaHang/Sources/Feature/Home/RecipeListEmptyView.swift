//
//  RecipeListEmptyView.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import SwiftUI

struct RecipeListEmptyView: View {
    let imageName: String = "crying_recipe"
    let text: String = "아직 변환한 레시피가 없어요"
    
    var body: some View {
        Spacer()
        
        VStack {
            Image(imageName)
                .padding(.bottom, 20)
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundStyle(AppColor.Text.emptyList)
        }
        .padding(.bottom, 100)
        
        Spacer()
    }
}
