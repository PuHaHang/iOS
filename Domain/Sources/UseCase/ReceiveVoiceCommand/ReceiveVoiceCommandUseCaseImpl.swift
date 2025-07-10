//
//  GetVoiceCommandStreamUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 7/6/25.
//

import Entity
import Foundation

public struct ReceiveVoiceCommandUseCaseImpl: ReceiveVoiceCommandUseCase {
    private let voiceCommandRepository: VoiceCommandRepository

    public init(voiceCommandRepository: VoiceCommandRepository) {
        self.voiceCommandRepository = voiceCommandRepository
    }

    public func execute() async -> Result<VoiceVO, Error> {
        do {
            let command = try await voiceCommandRepository.awaitVoiceCommand()
            return .success(command)
        } catch {
            return .failure(error)
        }
    }
}
