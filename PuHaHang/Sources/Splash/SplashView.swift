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
                IdleView()
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
        let appIconName: String = "splash_icon"
        
        var body: some View {
            Image(appIconName)
                .frame(width: 140, height: 150)
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
