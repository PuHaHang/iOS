//
//  AudioInputDataSource.swift
//  Data
//
//  Created by 디해 on 7/8/25.
//

import AVFAudio
import Combine
import Foundation

public protocol AudioInputDataSource {
    var sharedBuffer: AnyPublisher<AVAudioPCMBuffer, Never> { get }
    
    func checkMicrophonePermission() async -> Bool
    func startIfNeeded() throws
    func stopIfNeeded()
}
