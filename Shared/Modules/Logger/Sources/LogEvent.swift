//
//  LogEvent.swift
//  Logger
//
//  Created by 디해 on 7/31/25.
//

import Foundation

public enum LogEvent {
    // Screen Events
    case homeScreen
    case detailScreen
    case cookingScreen
    case convertScreen
    case conversionProcessScreen
    case conversionResultScreen
    case resultScreen
    case failedScreen
    case settingScreen
    case splashScreen
    
    // Initial Onboarding Screen Events
    case onboardingLoginScreen
    case onboardingIntroductionScreen
    case onboardingConversionExampleScreen
    case onboardingConversionScreen
    case onboardingResultScreen
    
    // Cooking Onboarding Screen Events
    case cookingOnboardingIntroScreen
    case cookingOnboardingVoicePermissionScreen
    case cookingOnboardingIntroductionScreen
    case cookingOnboardingCompletionScreen
    case cookingDestinationDismiss
    case cookingVoiceRecognized(recipeId: Int64, step: Int, text: String)
    
    // Button Events
    // Tab Buttons
    case homeTabButton
    case settingTabButton
    case plusTabButton
    
    // Home Screen Buttons
    case homeRecipeItemButton(servings: Int)
    case homeRecipeItemDeleteButton
    
    // Detail Screen Buttons
    case detailCookingButton
    case detailContentButton
    case detailStepsTabButton
    case detailIngredientsTabButton
    
    // Cooking Screen Buttons
    case cookingPrevButton(step: Int, elapsed: TimeInterval)
    case cookingNextButton(step: Int, elapsed: TimeInterval)
    case cookingTimerButton
    case cookingVoiceButton
    case cookingSpeakingButton
    case cookingSourceButton
    
    // Convert Screen Buttons
    case convertConvertButton
    
    // ConversionResult Screen Buttons
    case conversionResultConfirmButton
    case conversionFailedConfirmButton
    
    // Result Screen Buttons
    case resultHomeButton
    
    // Timer Modal Buttons
    case timerCancelButton
    case timerConfirmButton
    
    // Setting Screen Buttons
    case settingInstagramButton
    
    // Onboarding Buttons
    case onboardingLoginStartButton
    case onboardingIntroductionNextButton
    case onboardingConversionExampleConvertButton
    case onboardingConversionNotificationButton
    case onboardingResultStartButton
    case cookingOnboardingIntroStartButton
    case cookingOnboardingVoicePermissionButton
    case cookingOnboardingCompletionConfirmButton
}

extension LogEvent {
    public var item: LogEventItem {
        switch self {
        // Screen Events
        case .homeScreen:
            LogEventItem(
                type: .screen("Home"),
                message: nil,
                properties: nil
            )
        case .detailScreen:
            LogEventItem(
                type: .screen("Detail"),
                message: nil,
                properties: nil
            )
        case .cookingScreen:
            LogEventItem(
                type: .screen("Cooking"),
                message: nil,
                properties: nil
            )
        case .convertScreen:
            LogEventItem(
                type: .screen("Convert"),
                message: nil,
                properties: nil
            )
        case .conversionProcessScreen:
            LogEventItem(
                type: .screen("ConversionProcess"),
                message: nil,
                properties: nil
            )
        case .conversionResultScreen:
            LogEventItem(
                type: .screen("ConversionResult"),
                message: nil,
                properties: nil
            )
        case .resultScreen:
            LogEventItem(
                type: .screen("Result"),
                message: nil,
                properties: nil
            )
        case .failedScreen:
            LogEventItem(
                type: .screen("Failed"),
                message: nil,
                properties: nil
            )
        case .settingScreen:
            LogEventItem(
                type: .screen("Setting"),
                message: nil,
                properties: nil
            )
        case .splashScreen:
            LogEventItem(
                type: .screen("Splash"),
                message: nil,
                properties: nil
            )
        case .onboardingLoginScreen:
            LogEventItem(
                type: .screen("OnboardingLogin"),
                message: nil,
                properties: nil
            )
        case .onboardingIntroductionScreen:
            LogEventItem(
                type: .screen("OnboardingIntroduction"),
                message: nil,
                properties: nil
            )
        case .onboardingConversionExampleScreen:
            LogEventItem(
                type: .screen("OnboardingConversionExample"),
                message: nil,
                properties: nil
            )
        case .onboardingConversionScreen:
            LogEventItem(
                type: .screen("OnboardingConversion"),
                message: nil,
                properties: nil
            )
        case .onboardingResultScreen:
            LogEventItem(
                type: .screen("OnboardingResult"),
                message: nil,
                properties: nil
            )
        case .cookingOnboardingIntroScreen:
            LogEventItem(
                type: .screen("CookingOnboardingIntro"),
                message: nil,
                properties: nil
            )
        case .cookingOnboardingVoicePermissionScreen:
            LogEventItem(
                type: .screen("CookingOnboardingVoicePermission"),
                message: nil,
                properties: nil
            )
        case .cookingOnboardingIntroductionScreen:
            LogEventItem(
                type: .screen("CookingOnboardingIntroduction"),
                message: nil,
                properties: nil
            )
        case .cookingOnboardingCompletionScreen:
            LogEventItem(
                type: .screen("CookingOnboardingCompletion"),
                message: nil,
                properties: nil
            )
        case .cookingDestinationDismiss:
            LogEventItem(
                type: .dismiss("CookingDestination"),
                message: nil,
                properties: nil
            )
            
        case .cookingVoiceRecognized(let recipeId, let step, let text):
            LogEventItem(
                type: .voiceRecognition(text),
                message: nil,
                properties: [
                    "recipeId": recipeId,
                    "step": step
                ]
            )
            
        // Button Events
        // Tab Buttons
        case .homeTabButton:
            LogEventItem(
                type: .buttonClick("Tab", "Home"),
                message: nil,
                properties: nil
            )
        case .settingTabButton:
            LogEventItem(
                type: .buttonClick("Tab", "Setting"),
                message: nil,
                properties: nil
            )
        case .plusTabButton:
            LogEventItem(
                type: .buttonClick("Tab", "Plus"),
                message: nil,
                properties: nil
            )
            
        // Home Screen Buttons
        case .homeRecipeItemButton(let servings):
            LogEventItem(
                type: .buttonClick("Home", "RecipeItem"),
                message: nil,
                properties: [
                    "servings": servings
                ]
            )
            
        case .homeRecipeItemDeleteButton:
            LogEventItem(
                type: .buttonClick("Home", "RecipeItemDelete"),
                message: nil,
                properties: nil
            )
            
        // Detail Screen Buttons
        case .detailCookingButton:
            LogEventItem(
                type: .buttonClick("Detail", "Cooking"),
                message: nil,
                properties: nil
            )
        case .detailContentButton:
            LogEventItem(
                type: .buttonClick("Detail", "Content"),
                message: nil,
                properties: nil
            )
        case .detailStepsTabButton:
            LogEventItem(
                type: .buttonClick("Detail", "StepsTab"),
                message: nil,
                properties: nil
            )
        case .detailIngredientsTabButton:
            LogEventItem(
                type: .buttonClick("Detail", "IngredientsTab"),
                message: nil,
                properties: nil
            )
            
        // Cooking Screen Buttons
        case .cookingPrevButton(let step):
            LogEventItem(
                type: .buttonClick("Cooking", "Prev"),
                message: nil,
                properties: [
                    "step": step
                ]
            )
        case .cookingNextButton(let step):
            LogEventItem(
                type: .buttonClick("Cooking", "Next"),
                message: nil,
                properties: [
                    "step": step
                ]
            )
        case .cookingTimerButton:
            LogEventItem(
                type: .buttonClick("Cooking", "Timer"),
                message: nil,
                properties: nil
            )
        case .cookingVoiceButton:
            LogEventItem(
                type: .buttonClick("Cooking", "Voice"),
                message: nil,
                properties: nil
            )
        case .cookingSpeakingButton:
            LogEventItem(
                type: .buttonClick("Cooking", "Speaking"),
                message: nil,
                properties: nil
            )
        case .cookingSourceButton:
            LogEventItem(
                type: .buttonClick("Cooking", "Source"),
                message: nil,
                properties: nil
            )
            
        // Convert Screen Buttons
        case .convertConvertButton:
            LogEventItem(
                type: .buttonClick("Convert", "Convert"),
                message: nil,
                properties: nil
            )
            
        // ConversionResult Screen Buttons
        case .conversionResultConfirmButton:
            LogEventItem(
                type: .buttonClick("ConversionResult", "Confirm"),
                message: nil,
                properties: nil
            )
            
        case .conversionFailedConfirmButton:
            LogEventItem(
                type: .buttonClick("ConversionFailed", "Confirm"),
                message: nil,
                properties: nil
            )
            
        // Result Screen Buttons
        case .resultHomeButton:
            LogEventItem(
                type: .buttonClick("Result", "Home"),
                message: nil,
                properties: nil
            )
            
        // Timer Modal Buttons
        case .timerCancelButton:
            LogEventItem(
                type: .buttonClick("Timer", "Cancel"),
                message: nil,
                properties: nil
            )
        case .timerConfirmButton:
            LogEventItem(
                type: .buttonClick("Timer", "Confirm"),
                message: nil,
                properties: nil
            )
            
        // Setting Screen Buttons
        case .settingInstagramButton:
            LogEventItem(
                type: .buttonClick("Setting", "Instagram"),
                message: nil,
                properties: nil
            )
            
        // Onboarding Buttons
        case .onboardingLoginStartButton:
            LogEventItem(
                type: .buttonClick("OnboardingLogin", "Start"),
                message: nil,
                properties: nil
            )
        case .onboardingIntroductionNextButton:
            LogEventItem(
                type: .buttonClick("OnboardingIntroduction", "Next"),
                message: nil,
                properties: nil
            )
        case .onboardingConversionExampleConvertButton:
            LogEventItem(
                type: .buttonClick("OnboardingConversionExample", "Convert"),
                message: nil,
                properties: nil
            )
        case .onboardingConversionNotificationButton:
            LogEventItem(
                type: .buttonClick("OnboardingConversion", "Notification"),
                message: nil,
                properties: nil
            )
        case .onboardingResultStartButton:
            LogEventItem(
                type: .buttonClick("OnboardingResult", "Start"),
                message: nil,
                properties: nil
            )
        case .cookingOnboardingIntroStartButton:
            LogEventItem(
                type: .buttonClick("CookingOnboardingIntro", "Start"),
                message: nil,
                properties: nil
            )
        case .cookingOnboardingVoicePermissionButton:
            LogEventItem(
                type: .buttonClick("CookingOnboardingVoicePermission", "VoicePermission"),
                message: nil,
                properties: nil
            )
        case .cookingOnboardingCompletionConfirmButton:
            LogEventItem(
                type: .buttonClick("CookingOnboardingCompletion", "Confirm"),
                message: nil,
                properties: nil
            )
        }
    }
}
