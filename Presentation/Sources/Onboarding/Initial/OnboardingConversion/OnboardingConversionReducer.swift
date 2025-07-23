//
//  OnboardingConversionReducer.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Foundation
import UIKit
import UserNotifications

@Reducer
struct OnboardingConversionReducer {
    @Dependency(\.fetchRecipeDetailUseCase) var fetchRecipeDetailUseCase
    
    @ObservableState
    struct State {
        let permissionGuideText: String = """
            이 기능을 사용하려면 알림 권한이 필요해요.
            아래 버튼을 눌러주세요.
            """
    }
    
    enum Action {
        case didTapNotiPermissionButton
        case requestSampleRecipe
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapNotiPermissionButton:
                return .run { send in
                    await requestPushPermission()
                    await send(.requestSampleRecipe)
                }
                
            case .requestSampleRecipe:
                return .run { send in
                    let result = await fetchRecipeDetailUseCase.execute(recipeID: UUID())
                    switch result {
                    case .success(let detail):
                        let preview = detail.toRecipePreviewViewData()
                        await send(.delegate(.navigateToConversionResult(preview)))
                    case .failure(let error):
                        print(">>> \(error)")
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
        case navigateToConversionResult(RecipePreviewViewData)
    }
}
