//
//  EmptyAudioService.swift
//  Audio
//
//  Created by 디해 on 7/13/25.
//

import Foundation

public struct EmptyAudioService: AudioService {
    public func requestMicrophonePermission() async -> Bool {
        throwUnimplemented()
    }
    
    public func requestSpeechRecognitionPermission() async -> Bool {
        throwUnimplemented()
    }
    
    public func startCapture() async throws {
        throwUnimplemented()
    }
    
    public func stopCapture() {
        throwUnimplemented()
    }
    
    public func getNextVoice() async throws -> String {
        throwUnimplemented()
    }
    
    public func stopVoiceRecognition() {
        throwUnimplemented()
    }
    
    public func updateAudioSettings(for mode: AudioMode) throws {
        throwUnimplemented()
    }
    
    public func read(text: String) async {
        throwUnimplemented()
    }
    
    public func stopReading() {
        throwUnimplemented()
    }
}
