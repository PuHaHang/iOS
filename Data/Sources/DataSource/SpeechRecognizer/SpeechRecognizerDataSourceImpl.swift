//
//  SpeechRecognizerDataSourceImpl.swift
//  Data
//
//  Created by 디해 on 7/7/25.
//

import Combine
import Foundation
import Speech

public final class SpeechRecognizerDataSourceImpl: SpeechRecognizerDataSource {
    private let audioInputDataSource: AudioInputDataSource
    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var silenceTimer: Timer?
    
    private var cancellables = Set<AnyCancellable>()
    private var continuation: CheckedContinuation<String, Error>?
    
    private var lastRecognizedText: String = ""
    
    public init(audioInputDataSource: AudioInputDataSource) {
        self.audioInputDataSource = audioInputDataSource
    }
    
    public func requestAuthorization() async -> Bool {
        let status = await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }
        
        return status == .authorized
    }
    
    public func getNextVoiceText() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            
            do {
                try startRecognition()
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    public func stopRecognition() {
        clearRecognition()
        continuation?.resume(returning: "")
        continuation = nil
        audioInputDataSource.stopIfNeeded()
    }
}

private extension SpeechRecognizerDataSourceImpl {
    func startRecognition() throws {
        try audioInputDataSource.startIfNeeded()
        guard let recognizer, recognizer.isAvailable else { throw SpeechRecognizerError.unavailable }
        
        let request = makeRecognitionRequest()
        self.request = request
        
        let task = makeRecognitionTask(recognizer: recognizer, request: request)
        self.recognitionTask = task
        
        audioInputDataSource.sharedBuffer
            .sink { buffer in
                request.append(buffer)
            }
            .store(in: &cancellables)
    }
    
    func makeRecognitionRequest() -> SFSpeechAudioBufferRecognitionRequest {
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        return request
    }
    
    func makeRecognitionTask(
        recognizer: SFSpeechRecognizer,
        request: SFSpeechAudioBufferRecognitionRequest
    ) -> SFSpeechRecognitionTask {
        return recognizer.recognitionTask(with: request) { [weak self] result, error in
            guard let self else { return }
            
            if let error {
                continuation?.resume(throwing: error)
                return
            }
            
            guard let result else { return }
            
            if result.isFinal {
                continuation?.resume(returning: lastRecognizedText)
                continuation = nil
            } else {
                let text = result.bestTranscription.formattedString
                guard !text.isEmpty else { return }
                lastRecognizedText = text
                restartSilenceTimer()
            }
        }
    }
}

private extension SpeechRecognizerDataSourceImpl {
    func clearRecognition() {
        invalidateSilenceTimer()
        
        request?.endAudio()
        recognitionTask?.cancel()
        request = nil
        recognitionTask = nil
        cancellables.removeAll()
    }
    
    func restartSilenceTimer() {
        silenceTimer?.invalidate()
        silenceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self else { return }
            clearRecognition()
        }
    }
    
    func invalidateSilenceTimer() {
        silenceTimer?.invalidate()
        silenceTimer = nil
    }
}
