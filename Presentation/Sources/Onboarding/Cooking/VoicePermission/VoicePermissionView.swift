//
//  VoicePermissionView.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import SwiftUI

struct VoicePermissionView: View {
    @Bindable var store: StoreOf<VoicePermissionReducer>
        
    var body: some View {
        VStack(spacing: 0) {
            Text(store.titleText)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(AppColor.Text.main)
                .padding(.top, 80)
            
            Spacer()
            
            Text(store.subTitleText)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(AppColor.main)
                .padding(.bottom, 35)
            
            MiniRoundedButton(title: "음성 켜기") {
                store.send(.didTapVoiceButton)
            }.padding(.bottom, 70)
        }
        .toolbar(.hidden)
    }
}
