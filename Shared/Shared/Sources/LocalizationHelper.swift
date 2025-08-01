//
//  LocalizationHelper.swift
//  Shared
//
//  Created by 디해 on 6/13/25.
//

import Foundation

public struct LocalizationHelper {
    public static func localizedString(for key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    public static func localizedString(for key: String, arguments: CVarArg...) -> String {
        let format = NSLocalizedString(key, comment: "")
        return String(format: format, arguments: arguments)
    }
}

// MARK: - String Extension
public extension String {
    var localized: String {
        return LocalizationHelper.localizedString(for: self)
    }
    
    func localized(with arguments: CVarArg...) -> String {
        return LocalizationHelper.localizedString(for: self, arguments: arguments)
    }
}

// MARK: - Common Localized Strings
public extension LocalizationHelper {
    
    // MARK: - Common
    static var ok: String { "common.ok".localized }
    static var cancel: String { "common.cancel".localized }
    static var save: String { "common.save".localized }
    static var delete: String { "common.delete".localized }
    static var edit: String { "common.edit".localized }
    static var back: String { "common.back".localized }
    
    // MARK: - Tab Bar
    static var home: String { "tab.home".localized }
    static var convert: String { "tab.convert".localized }
    static var cooking: String { "tab.cooking".localized }
    static var settings: String { "tab.settings".localized }
    
    // MARK: - Home
    static var homeTitle: String { "home.title".localized }
    static var homeSubtitle: String { "home.subtitle".localized }
    static var homeEmptyTitle: String { "home.empty.title".localized }
    static var homeEmptySubtitle: String { "home.empty.subtitle".localized }
    
    // MARK: - Convert
    static var convertTitle: String { "convert.title".localized }
    static var convertHighlightedInfo: String { "convert.highlighted_info".localized }
    static var convertInfo: String { "convert.info".localized }
    static var convertWarning: String { "convert.warning".localized }
    static var convertPlaceholder: String { "convert.placeholder".localized }
    static var convertButton: String { "convert.button".localized }
    static var convertStartRecording: String { "convert.start_recording".localized }
    static var convertStopRecording: String { "convert.stop_recording".localized }
    static var convertProcessing: String { "convert.processing".localized }
    
    // MARK: - Cooking
    static var cookingTitle: String { "cooking.title".localized }
    static var cookingIngredients: String { "cooking.ingredients".localized }
    static var cookingSteps: String { "cooking.steps".localized }
    static var cookingTimer: String { "cooking.timer".localized }
    static var cookingStart: String { "cooking.start".localized }
    static var cookingPause: String { "cooking.pause".localized }
    static var cookingReset: String { "cooking.reset".localized }
    static var cookingPrevious: String { "cooking.previous".localized }
    static var cookingNext: String { "cooking.next".localized }
    static var cookingCompletionTitle: String { "cooking.completion.title".localized }
    static var cookingCompletionHome: String { "cooking.completion.home".localized }
    
    // MARK: - Recipe
    static var recipeStep: String { "recipe.step".localized }
    static var recipeIngredient: String { "recipe.ingredient".localized }
    static var recipeServing: String { "recipe.serving".localized }
    static var recipeServingUnit: String { "recipe.serving.unit".localized }
    
    // MARK: - Settings
    static var settingsTitle: String { "settings.title".localized }
    static var settingsLanguage: String { "settings.language".localized }
    static var settingsNotifications: String { "settings.notifications".localized }
    static var settingsAbout: String { "settings.about".localized }
    static var settingsInstagramTitle: String { "settings.instagram.title".localized }
    static var settingsInstagramSubtitle: String { "settings.instagram.subtitle".localized }
    
    // MARK: - Timer
    static var timerSettingTitle: String { "timer.setting.title".localized }
    static var timerMinute: String { "timer.minute".localized }
    static var timerSecond: String { "timer.second".localized }
    static var timerRemaining: String { "timer.remaining".localized }
    static var timerCompletion: String { "timer.completion".localized }
    static var timerSet: String { "timer.set".localized }
    static var timerCancel: String { "timer.cancel".localized }
    static var timerOk: String { "timer.ok".localized }
    
    // MARK: - Detail
    static var detailCooking: String { "detail.cooking".localized }
    static var detailOriginalContent: String { "detail.original_content".localized }
    static var detailStepTitle: String { "detail.step.title".localized }
    
    // MARK: - Conversion Process
    static var conversionProcessTitle: String { "conversion.process.title".localized }
    static var conversionProcessSubtitle: String { "conversion.process.subtitle".localized }
    
    // MARK: - Conversion Result
    static var conversionResultTitle: String { "conversion.result.title".localized }
    static var conversionResultOk: String { "conversion.result.ok".localized }
    
    // MARK: - Onboarding
    static var onboardingWelcome: String { "onboarding.welcome".localized }
    static var onboardingDescription: String { "onboarding.description".localized }
    static var onboardingStart: String { "onboarding.start".localized }
    static var onboardingLoginWelcome: String { "onboarding.login.welcome".localized }
    static var onboardingLoginSubtitle: String { "onboarding.login.subtitle".localized }
    static var onboardingLoginStart: String { "onboarding.login.start".localized }
    static var onboardingIntroductionTitle: String { "onboarding.introduction.title".localized }
    static var onboardingIntroductionSubtitle: String { "onboarding.introduction.subtitle".localized }
    static var onboardingIntroductionNext: String { "onboarding.introduction.next".localized }
    static var onboardingConversionExampleConvert: String { "onboarding.conversion.example.convert".localized }
    static var onboardingResultStart: String { "onboarding.result.start".localized }
    static var onboardingCookingIntroStart: String { "onboarding.cooking.intro.start".localized }
    static var onboardingCookingCompletionOk: String { "onboarding.cooking.completion.ok".localized }
    static var onboardingCookingVoicePermission: String { "onboarding.cooking.voice.permission".localized }
    static var onboardingConversionNotification: String { "onboarding.conversion.notification".localized }
    static var onboardingConversionExampleTitle: String { "onboarding.conversion.example.title".localized }
    static var onboardingConversionExampleSubtitle: String { "onboarding.conversion.example.subtitle".localized }
    static var onboardingConversionExampleURL: String { "onboarding.conversion.example.url".localized }
    static var onboardingConversionPermissionGuide: String { "onboarding.conversion.permission.guide".localized }
    static var onboardingCookingIntroTitle: String { "onboarding.cooking.intro.title".localized }
    static var onboardingCookingIntroSubtitle: String { "onboarding.cooking.intro.subtitle".localized }
    static var onboardingCookingIntroIntroduction: String { "onboarding.cooking.intro.introduction".localized }
    static var onboardingCookingCompletionTitle: String { "onboarding.cooking.completion.title".localized }
    static var onboardingVoicePermissionTitle: String { "onboarding.voice.permission.title".localized }
    static var onboardingVoicePermissionSubtitle: String { "onboarding.voice.permission.subtitle".localized }
    static var onboardingResultTitle: String { "onboarding.result.title".localized }
    static var onboardingResultSubtitle: String { "onboarding.result.subtitle".localized }
    
    // MARK: - Cooking Introduction
    static var cookingIntroductionSkip: String { "cooking.introduction.skip".localized }
    static var cookingIntroductionMicrophoneTitle: String { "cooking.introduction.microphone.title".localized }
    static var cookingIntroductionMicrophoneIntroduction: String { "cooking.introduction.microphone.introduction".localized }
    static var cookingIntroductionStepTitle: String { "cooking.introduction.step.title".localized }
    static var cookingIntroductionStepSubtitle: String { "cooking.introduction.step.subtitle".localized }
    static var cookingIntroductionPlayTitle: String { "cooking.introduction.play.title".localized }
    static var cookingIntroductionPlaySubtitle: String { "cooking.introduction.play.subtitle".localized }
    static var cookingIntroductionTimerTitle: String { "cooking.introduction.timer.title".localized }
    static var cookingIntroductionTimerSubtitle: String { "cooking.introduction.timer.subtitle".localized }
    static var cookingIntroductionSpeakerTitle: String { "cooking.introduction.speaker.title".localized }
    static var cookingIntroductionSpeakerSubtitle: String { "cooking.introduction.speaker.subtitle".localized }
    
    // MARK: - Error Messages
    static var errorNetwork: String { "error.network".localized }
    static var errorVoiceRecognition: String { "error.voice_recognition".localized }
    static var errorConversion: String { "error.conversion".localized }
    static var errorUnknown: String { "error.unknown".localized }
    
    // MARK: - Success Messages
    static var successConversion: String { "success.conversion".localized }
    static var successSaved: String { "success.saved".localized }
    
    // MARK: - Splash
    static var splashSubtitle: String { "splash.subtitle".localized }
} 
