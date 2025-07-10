//
//  SpeechRecognizerRepositoryImpl.swift
//  Data
//
//  Created by 디해 on 7/6/25.
//

import AVFoundation
import Combine
import Domain
import Entity
import Foundation
import Speech

public final class VoiceCommandRepositoryImpl: VoiceCommandRepository {
    private let audioInputDataSource: AudioInputDataSource
    private let speechRecognizerDataSource: SpeechRecognizerDataSource
    
    public init(
        audioInputDataSource: AudioInputDataSource,
        speechRecognizerDataSource: SpeechRecognizerDataSource
    ) {
        self.audioInputDataSource = audioInputDataSource
        self.speechRecognizerDataSource = speechRecognizerDataSource
    }

    public func requestAuthorization() async -> Bool {
        let microPermission = await audioInputDataSource.checkMicrophonePermission()
        let speechPermission = await speechRecognizerDataSource.requestAuthorization()
        
        return microPermission && speechPermission
    }

    public func awaitVoiceCommand() async throws -> VoiceVO {
        let text = try await speechRecognizerDataSource.getNextVoiceText()
        let command = parseVoiceCommand(from: text)
        return VoiceVO(text: text, command: command)
    }

    public func cancelRecognition() {
        speechRecognizerDataSource.stopRecognition()
    }
}

private extension VoiceCommandRepositoryImpl {
    func parseVoiceCommand(from text: String) -> VoiceCommandVO {
        let normalized = text.replacingOccurrences(of: " ", with: "")
        
        if let minutes = extractMinutes(from: normalized),
           let seconds = extractSeconds(from: normalized) {
            return .timer(minutes: minutes, seconds: seconds)
        }
        
        if let minutes = extractMinutes(from: normalized) {
            return .timer(minutes: minutes, seconds: 0)
        }
        
        if let seconds = extractSeconds(from: normalized) {
            return .timer(minutes: 0, seconds: seconds)
        }
        
        if ["이전", "뒤로"].contains(normalized) {
            return .previous
        }
        
        if ["다음"].contains(normalized) {
            return .next
        }
        
        if ["영상보여줘", "영상틀어줘", "비디오틀어줘", "재생", "재생해줘", "틀어줘"].contains(normalized) {
            return .playVideo
        }
        
        if ["영상꺼줘", "비디오꺼줘", "정지", "정지해줘", "꺼줘"].contains(normalized) {
            return .stopVideo
        }
        
        if ["타이머꺼줘", "타이머취소"].contains(normalized) {
            return .stopTimer
        }
        
        return .unknown
    }
    
    func extractMinutes(from text: String) -> Int? {
        let pattern = #"타이머([가-힣0-9]+?)분"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        
        guard let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
              let range = Range(match.range(at: 1), in: text)
        else { return nil }
        
        let captured = String(text[range])
        
        if let intVal = Int(captured) {
            return intVal
        }
        
        return koreanNumberToInt(captured)
    }
    
    func extractSeconds(from text: String) -> Int? {
        let pattern = #"타이머(?:[0-9가-힣]+분)?([0-9가-힣]+)초"#
        
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        
        guard let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
              let range = Range(match.range(at: 1), in: text) else { return nil }

        let captured = String(text[range])

        if let value = Int(captured) {
            return value
        }

        return koreanNumberToInt(captured)
    }
    
    func koreanNumberToInt(_ text: String) -> Int {
        let map: [String: Int] = [
            "영": 0, "일": 1, "이": 2, "삼": 3, "사": 4, "오": 5,
            "육": 6, "칠": 7, "팔": 8, "구": 9, "십": 10
        ]
        
        if text == "십" {
            return 10
        } else if text.hasPrefix("십") {
            let unit = String(text.dropFirst())
            return 10 + (map[unit] ?? 0)
        } else if text.hasSuffix("십") {
            let ten = String(text.dropLast())
            return (map[ten] ?? 1) * 10
        } else if text.contains("십") {
            let parts = text.split(separator: "십")
            let tens = map[String(parts[0])] ?? 1
            let ones = map[String(parts[1])] ?? 0
            return tens * 10 + ones
        } else {
            return map[text] ?? 0
        }
    }
}
