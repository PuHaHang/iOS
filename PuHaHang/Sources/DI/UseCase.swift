//
//  UseCase.swift
//  PuHaHang
//
//  Created by 디해 on 7/2/25.
//

import Dependencies
import Foundation
import Domain

extension IntroUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any IntroUseCase = {
        @Dependency(\.introRepository) var introRepository
        return IntroUseCaseImpl(introRepository: introRepository)
    }()
}

extension FetchConvertedRecipeIDUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchConvertedRecipeIDUseCase = {
        @Dependency(\.recipeConversionRepository) var recipeConversionRepository
        return FetchConvertedRecipeIDUseCaseImpl(recipeConversionRepository: recipeConversionRepository)
    }()
}

extension FetchRecipeDetailUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchRecipeDetailUseCase = {
        @Dependency(\.recipeDetailRepository) var recipeDetailRepository
        return FetchRecipeDetailUseCaseImpl(recipeDetailRepository: recipeDetailRepository)
    }()
}

extension FetchRecipePreviewUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchRecipePreviewUseCase = {
        @Dependency(\.recipePreviewRepository) var recipePreviewRepository
        return FetchRecipePreviewUseCaseImpl(recipePreviewRepository: recipePreviewRepository)
    }()
}

extension FetchRecipePreviewsUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchRecipePreviewsUseCase = {
        @Dependency(\.recipePreviewRepository) var recipePreviewRepository
        return FetchRecipePreviewsUseCaseImpl(recipePreviewRepository: recipePreviewRepository)
    }()
}

extension RequestVoiceAuthorizationUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any RequestVoiceAuthorizationUseCase = {
        @Dependency(\.voiceCommandRepository) var voiceCommandRepository
        return RequestVoiceAuthorizationUseCaseImpl(voiceCommandRepository: voiceCommandRepository)
    }()
}

extension ReceiveVoiceCommandUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any ReceiveVoiceCommandUseCase = {
        @Dependency(\.voiceCommandRepository) var voiceCommandRepository
        return ReceiveVoiceCommandUseCaseImpl(voiceCommandRepository: voiceCommandRepository)
    }()
}

extension StopSpeechRecognitionUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any StopSpeechRecognitionUseCase = {
        @Dependency(\.voiceCommandRepository) var voiceCommandRepository
        return StopSpeechRecognitionUseCaseImpl(voiceCommandRepository: voiceCommandRepository)
    }()
}
