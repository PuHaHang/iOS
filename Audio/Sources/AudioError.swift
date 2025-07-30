//
//  AudioError.swift
//  Audio
//
//  Created by 디해 on 7/13/25.
//

import Foundation

public enum AudioError: Error {
    case permissionDenied
    case speechRecognizerUnavailable
    case recognitionRequestFailed
    case platformNotSupported
    
    public var errorDescription: String {
        switch self {
        case .permissionDenied:
            return "마이크 또는 음성 인식 권한이 거부되었습니다."
        case .speechRecognizerUnavailable:
            return "음성 인식 서비스를 사용할 수 없습니다."
        case .recognitionRequestFailed:
            return "음성 인식 요청을 생성할 수 없습니다."
        case .platformNotSupported:
            return "현재 플랫폼에서는 음성 인식을 지원하지 않습니다."
        }
    }
}
