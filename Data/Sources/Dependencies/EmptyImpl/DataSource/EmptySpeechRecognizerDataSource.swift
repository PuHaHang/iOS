//
//  EmptySpeechRecognizerDataSource.swift
//  Data
//
//  Created by 디해 on 7/7/25.
//

import Combine
import Foundation
import Speech

public struct EmptySpeechRecognizerDataSource: SpeechRecognizerDataSource {
    public func requestAuthorization() async -> Bool {
        throwUnimplemented()
    }
    
    public func getNextVoiceText() async throws -> String {
        throwUnimplemented()
    }
    
    public func stopRecognition() {
        throwUnimplemented()
    }
}
