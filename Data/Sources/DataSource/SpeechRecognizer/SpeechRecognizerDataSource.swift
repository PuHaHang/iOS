//
//  SpeechRecognizerDataSource.swift
//  Data
//
//  Created by 디해 on 7/7/25.
//

import Combine
import Foundation

public protocol SpeechRecognizerDataSource {
    func requestAuthorization() async -> Bool
    func getNextVoiceText() async throws -> String
    func stopRecognition()
}
