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
        }.onAppear {
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
            Text(error.localizedDescription)
        }
    }
}
