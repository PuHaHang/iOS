//
//  ConversionResultView.swift
//  Presentation
//
//  Created by 디해 on 7/12/25.
//

import ComposableArchitecture
import Shared
import SwiftUI

struct ConversionResultView: View {
    @Bindable var store: StoreOf<ConversionResultReducer>
    
    var body: some View {
        VStack {
            Spacer()
            Text(LocalizationHelper.conversionResultTitle)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(AppColor.Text.main)
                .padding(.bottom, 30)
            
            RecipePreviewView(recipePreviewViewData: store.recipePreviewViewData)
            
            Spacer()
            
            RoundedButton(title: LocalizationHelper.conversionResultOk, action: {
                store.send(.didTapComfirmButton)
            })
        }
        .padding(.horizontal, 25)
        .onAppear {
            store.send(.onAppear)
        }
        .toolbar(.hidden)
    }
}
