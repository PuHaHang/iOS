//
//  SplashView.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import ComposableArchitecture
import SwiftUI

struct SplashView: View {
    let store: StoreOf<SplashReducer>
    
    var body: some View {
        Group {
            switch store.introRoadState {
            case .idle:
                IdleView(appTitle: store.appTitle, appIconName: store.appIconName)
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
        let appTitle: String
        let appIconName: String
        
        var body: some View {
            VStack(spacing: 15) {
                Text(appTitle)
                    .foregroundColor(AppColor.main)
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                
                Image(appIconName)
                    .frame(width: 140, height: 150)
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
