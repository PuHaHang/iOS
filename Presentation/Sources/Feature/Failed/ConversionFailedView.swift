//
//  FailedView.swift
//  Presentation
//
//  Created by 디해 on 8/1/25.
//

import ComposableArchitecture
import Lottie
import Shared
import SwiftUI

struct ConversionFailedView: View {
    @Bindable var store: StoreOf<ConversionFailedReducer>
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("레시피 변환에 실패했어요")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(AppColor.Text.main)
                .padding(.bottom, 10)
            
            LottieView(animation: .named("failure"))
                .looping()
                .frame(height: 200)
            
            Spacer()
            
            Text("""
                - 네트워크 상태를 확인해 주세요.
                - 올바른 링크인지 다시 한 번 확인해 주세요.
                - 서버가 혼잡할 수 있으니 잠시 후 다시 시도해 주세요.
                """)
            .font(.system(size: 14))
            .fontWeight(.medium)
            .foregroundStyle(AppColor.Text.information)
            .multilineTextAlignment(.center)
            .padding(.bottom, 50)
            
            RoundedButton(
                title: LocalizationHelper.cookingCompletionHome) {
                    store.send(.didTapHomeButton)
                }
                .padding(.bottom, 20)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            store.send(.onAppear)
        }
    }
}
