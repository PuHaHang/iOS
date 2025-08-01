//
//  RecipeListEmptyView.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import Shared
import SwiftUI

struct RecipeListEmptyView: View {
    let imageName: String = "crying_recipe"
    let text: String = LocalizationHelper.homeEmptyTitle
    
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
