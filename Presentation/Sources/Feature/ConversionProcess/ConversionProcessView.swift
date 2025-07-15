//
//  ConversionProcessView.swift
//  Presentation
//
//  Created by 디해 on 7/12/25.
//

import ComposableArchitecture
import Lottie
import SwiftUI

struct ConversionProcessView: View {
    @Bindable var store: StoreOf<ConversionProcessReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            RecipeConvertingView()
            .offset(y: -45)
            
            Spacer()
        }
        .toolbar(.hidden)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

struct RecipeConvertingView: View {
    var body: some View {
        VStack(spacing: 0) {
            LottieView(animation: .named("recipe_conversion_process"))
                .looping()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140)
                .padding(.bottom, 33)
            
            Text("레시피를 만들고 있어요")
                .fontWeight(.bold)
                .font(.system(size: 23))
                .padding(.bottom, 25)
                .foregroundStyle(AppColor.Text.main)
            
            Text("화면을 떠나셔도 괜찮아요.\n변환이 완료되면 알림을 보내드릴게요.")
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundStyle(AppColor.Text.information)
                .multilineTextAlignment(.center)
        }
    }
}
