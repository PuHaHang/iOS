//
//  ConversionExampleView.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Shared
import SwiftUI

struct ConversionExampleView: View {
    @Bindable var store: StoreOf<ConversionExampleReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            Text(store.titleText)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(AppColor.Text.main)
                .padding(.top, 80)
                .padding(.bottom, 35)
            
            Text(store.subTitleText)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundStyle(AppColor.Text.information)
                .multilineTextAlignment(.center)
                .padding(.bottom, 55)
            
            Text(store.exampleURL)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColor.Text.example)
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(20)
                .background(AppColor.Component.textFieldBackground)
                .cornerRadius(10)
                .padding(.horizontal, 25)
                .padding(.bottom, 25)
            
            Spacer()
            
            RoundedButton(title: LocalizationHelper.onboardingConversionExampleConvert) {
                store.send(.didTapConvertButton)
            }
            .padding(.bottom, 50)
        }
        .padding(.horizontal, 25)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
        .onAppear {
            store.send(.onAppear)
        }
    }
}
