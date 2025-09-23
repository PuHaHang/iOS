//
//  AudioServiceImpl.swift
//  Audio
//
//  Created by 디해 on 7/13/25.
//

import AVFAudio
import Combine
import Foundation
import Speech

public final class AudioServiceImpl: NSObject, AudioService {
    private let audioEngine = AVAudioEngine()
    private let bufferSubject = PassthroughSubject<AVAudioPCMBuffer, Never>()
    private var mode: AudioMode = .earpiece
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var continuation: CheckedContinuation<String, Error>?
    private var silenceTimer: Timer?
    private var cancellables = Set<AnyCancellable>()
    private var isCapturing: Bool = false
    
    private var lastRecognizedText: String = ""
    
    private let synthesizer = AVSpeechSynthesizer()
    private var synthesizerContinuation: CheckedContinuation<Void, Never>?
    
    public override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    public func requestMicrophonePermission() async -> Bool {
        return await AVAudioApplication.requestRecordPermission()
    }
    
    public func requestSpeechRecognitionPermission() async -> Bool {
        let status = await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }
        return status == .authorized
    }
    
    public func startCapture() async throws {
        let microphonePermission = await requestMicrophonePermission()
        guard microphonePermission else { throw AudioError.permissionDenied }
        
        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        
        try updateAudioSettings(for: .earpiece)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            self?.bufferSubject.send(buffer)
        }
        
        try audioEngine.start()
        self.isCapturing = true
    }
    
    public func stopCapture() {
        guard isCapturing else { return }
        isCapturing = false
        
        clearRecognition()
        
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    public func getNextVoice() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            
            do {
                try startRecognition()
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    public func stopVoiceRecognition() {
        clearRecognition()
    }
    
    public func updateAudioSettings(for mode: AudioMode) throws {
        guard self.mode != mode else { return }
        
        self.mode = mode
        let session = AVAudioSession.sharedInstance()
        
        switch mode {
        case .speaker:
            try session.setCategory(
                .playAndRecord,
                mode: .default,
                options: [
                    .duckOthers,
                    .defaultToSpeaker,
                    .allowBluetooth,
                    .mixWithOthers
                ]
            )
            
        case .earpiece:
            try session.setCategory(
                .playAndRecord,
                mode: .voiceChat,
                options: [
                    .duckOthers,
                    .allowBluetooth,
                    .mixWithOthers
                ]
            )
        }
        
        try session.setActive(true)
    }
    
    public func read(text: String) async {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.volume = 1.0
        
        return await withCheckedContinuation { continuation in
            self.synthesizerContinuation = continuation
            synthesizer.speak(utterance)
        }
    }
    
    public func stopReading() {
        synthesizer.stopSpeaking(at: .immediate)
        synthesizerContinuation?.resume()
        synthesizerContinuation = nil
    }
}

private extension AudioServiceImpl {
    func startRecognition() throws {
        guard let speechRecognizer, speechRecognizer.isAvailable else {
            throw AudioError.speechRecognizerUnavailable
        }
        
        let request = makeRecognitionRequest()
        self.recognitionRequest = request
        
        let task = makeRecognitionTask(recognizer: speechRecognizer, request: request)
        self.recognitionTask = task
        
        bufferSubject.sink { buffer in
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
    
    func clearRecognition() {
        invalidateSilenceTimer()
        
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        
        recognitionRequest = nil
        recognitionTask = nil
        cancellables.removeAll()
    }
    
    func restartSilenceTimer() {
        silenceTimer?.invalidate()
        silenceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.clearRecognition()
        }
    }
    
    func invalidateSilenceTimer() {
        silenceTimer?.invalidate()
        silenceTimer = nil
    }
}

extension AudioServiceImpl: AVSpeechSynthesizerDelegate {
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        synthesizerContinuation?.resume()
        synthesizerContinuation = nil
    }
}
