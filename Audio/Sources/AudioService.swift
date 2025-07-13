import AVFAudio
import Combine
import Foundation
import Speech

public protocol AudioService {
    func requestMicrophonePermission() async -> Bool
    func requestSpeechRecognitionPermission() async -> Bool
    
    func startCapture() async throws
    func stopCapture()
    
    func getNextVoice() async throws -> String
    func stopVoiceRecognition()
    
    func updateAudioSettings(for mode: AudioMode) throws
    
    func read(text: String) async
    func stopReading()
}

public enum AudioMode {
    case earpiece
    case speaker
}
