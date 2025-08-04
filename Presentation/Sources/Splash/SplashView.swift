//
//  SplashView.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import ComposableArchitecture
import SwiftUI

public struct SplashView: View {
    let store: StoreOf<SplashReducer>
    
    public init(store: StoreOf<SplashReducer>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            Group {
                switch store.introState {
                case .idle:
                    IdleView(
                        appTitleIconName: store.appTitle,
                        appSubTitle: store.appSubTitle,
                        appIconName: store.appIconName
                    )
                case .onboarding:
                    RootView(store: Store(initialState: RootReducer.State(destination: .onboarding(.init())), reducer: {
                        RootReducer()
                    }))
                case .success:
                    RootView(store: Store(initialState: RootReducer.State(), reducer: {
                        RootReducer()
                    }))
                case .failure(let error):
                    FailureView(error: error)
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

extension SplashView {
    struct IdleView: View {
        let appTitleIconName: String
        let appSubTitle: String
        let appIconName: String
        
        var body: some View {
            VStack(spacing: 15) {
                Text(appSubTitle)
                    .foregroundStyle(AppColor.Text.subTitle)
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                
                Image(appIconName)
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 5)
                
                Image(appTitleIconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                
            }
            .padding(.bottom, 100)
        }
    }
    
    struct FailureView: View {
        let error: Error
        
        var body: some View {
            VStack {
                Text("버전 정보를 불러오는 과정에서\n문제가 발생했습니다.")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                Text("네트워크 연결을 확인한 뒤\n앱을 재시작해주세요.")
                    .font(.system(size: 16))
                    .foregroundStyle(AppColor.Text.information)
            }
        }
    }
}
