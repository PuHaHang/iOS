//
//  ConversionResultView.swift
//  Presentation
//
//  Created by 디해 on 7/12/25.
//

import ComposableArchitecture
import SwiftUI

struct ConversionResultView: View {
    @Bindable var store: StoreOf<ConversionResultReducer>
    
    var body: some View {
        VStack {
            Spacer()
            Text("레시피가 완성되었어요!")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(AppColor.Text.main)
                .padding(.bottom, 30)
            
            RecipePreviewView(recipePreviewViewData: store.recipePreviewViewData)
            
            Spacer()
            
            RoundedButton(title: "확인", action: {
                store.send(.didTapComfirmButton)
            })
            .padding(.bottom, 30)
        }
        .toolbar(.hidden)
    }
}
