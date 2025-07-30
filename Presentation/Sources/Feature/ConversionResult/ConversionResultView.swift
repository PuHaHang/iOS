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
            
            RecipePreviewView(store: store)
                .frame(width: 300, height: 480)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                )
            
            Spacer()
            
            RoundedButton(title: "확인", action: {
                store.send(.didTapComfirmButton)
            })
            .padding(.bottom, 30)
        }
        .toolbar(.hidden)
    }
}
