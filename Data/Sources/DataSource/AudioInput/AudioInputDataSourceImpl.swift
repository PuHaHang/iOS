//
//  AudioInputDataSourceImpl.swift
//  Data
//
//  Created by 디해 on 7/8/25.
//

import AVFAudio
import Combine
import Foundation

public final class AudioInputDataSourceImpl: AudioInputDataSource {
    private let audioEngine = AVAudioEngine()
    private var subject = PassthroughSubject<AVAudioPCMBuffer, Never>()
    private let lock = NSLock()
    
    private var subscriberCount = 0
    
    public var sharedBuffer: AnyPublisher<AVAudioPCMBuffer, Never> {
        subject.eraseToAnyPublisher()
    }
    
    public init() { }
    
    public func checkMicrophonePermission() async -> Bool {
        return await AVAudioApplication.requestRecordPermission()
    }
    
    public func startIfNeeded() throws {
        lock.lock()
        defer { lock.unlock() }
        
        subscriberCount += 1
        if subscriberCount == 1 { try startCapture() }
    }
    
    public func stopIfNeeded() {
        lock.lock()
        defer { lock.unlock() }
        
        subscriberCount = max(subscriberCount - 1, 0)
        if subscriberCount == 0 { stopCapture() }
    }
    
    private func startCapture() throws {
        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        subject = PassthroughSubject<AVAudioPCMBuffer, Never>()
        
        try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
        try AVAudioSession.sharedInstance().setActive(true)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            self?.subject.send(buffer)
        }
        
        try audioEngine.start()
    }
    
    private func stopCapture() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        subject.send(completion: .finished)
    }
}
