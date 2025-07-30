//
//  SettingReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation
import UIKit

@Reducer
struct SettingReducer {
    @ObservableState
    struct State: Equatable {
        let instagramURL: String = "https://www.naver.com"
        var isLoading = false
    }
    
    enum Action: Equatable {
        case visitInstagram
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .visitInstagram:
                if let url = URL(string: state.instagramURL) {
                    openURL(url)
                }
                return .none
            }
        }
    }
    
    private func openURL(_ url: URL) {
        UIApplication.shared.open(
            url,
            options: [:],
            completionHandler: nil
        )
    }
}
