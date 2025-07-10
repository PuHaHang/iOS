//
//  RequestVoiceAuthorizationUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 7/6/25.
//

import Foundation

public struct RequestVoiceAuthorizationUseCaseImpl: RequestVoiceAuthorizationUseCase {
    private let voiceCommandRepository: VoiceCommandRepository

    public init(voiceCommandRepository: VoiceCommandRepository) {
        self.voiceCommandRepository = voiceCommandRepository
    }

    public func execute() async -> Bool {
        await voiceCommandRepository.requestAuthorization()
    }
}
