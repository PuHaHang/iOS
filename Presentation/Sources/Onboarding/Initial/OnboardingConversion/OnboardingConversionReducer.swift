//
//  OnboardingConversionReducer.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Foundation
import Shared
import UIKit
import UserNotifications

@Reducer
struct OnboardingConversionReducer {
    @Dependency(\.fetchOnboardingImageUseCase) var fetchOnboardingImageUseCase
    
    @ObservableState
    struct State {
        let permissionGuideText: String = LocalizationHelper.onboardingConversionPermissionGuide
    }
    
    enum Action {
        case didTapNotiPermissionButton
        case requestSampleImage
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapNotiPermissionButton:
                return .run { send in
                    await requestPushPermission()
                    await send(.requestSampleImage)
                }
                
            case .requestSampleImage:
                return .run { send in
                    let result = try await fetchOnboardingImageUseCase.execute()
                    switch result {
                    case .success(let url):
                        await send(.delegate(.navigateToConversionResult(url)))
                    case .failure(let error):
                        await send(.delegate(.navigateToConversionResult(nil)))
                    }
                }
                
            case .delegate:
                return .none
            }
        }
    }
}

extension OnboardingConversionReducer {
    @discardableResult
    func requestPushPermission() async -> Bool {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        let granted = await withCheckedContinuation { continuation in
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions) { granted, _ in
                    continuation.resume(returning: granted)
                }
        }
        return granted
    }
}

extension OnboardingConversionReducer {
    enum Delegate {
        case navigateToConversionResult(URL?)
    }
}
