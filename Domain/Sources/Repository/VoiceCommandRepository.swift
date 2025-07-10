//
//  SpeechRecognizerRepository.swift
//  Domain
//
//  Created by 디해 on 7/6/25.
//

import Foundation
import Entity

public protocol VoiceCommandRepository {
    func requestAuthorization() async -> Bool
    func awaitVoiceCommand() async throws -> VoiceVO
    func cancelRecognition()
}
