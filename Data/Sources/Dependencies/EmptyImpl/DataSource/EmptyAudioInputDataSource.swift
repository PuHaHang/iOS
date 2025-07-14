//
//  EmptyAudioInputDataSource.swift
//  Data
//
//  Created by 디해 on 7/8/25.
//

import AVFAudio
import Combine
import Foundation

public struct EmptyAudioInputDataSource: AudioInputDataSource {
    private let subject = PassthroughSubject<AVAudioPCMBuffer, Never>()
    public var sharedBuffer: AnyPublisher<AVAudioPCMBuffer, Never> {
        subject.eraseToAnyPublisher()
    }
    
    public func checkMicrophonePermission() async -> Bool {
        throwUnimplemented()
    }
    
    public func startIfNeeded() throws {
        throwUnimplemented()
    }
    
    public func stopIfNeeded() {
        throwUnimplemented()
    }
}
