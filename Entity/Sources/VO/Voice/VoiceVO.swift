//
//  VoiceCommandVO.swift
//  Entity
//
//  Created by 디해 on 7/9/25.
//

import Foundation

public struct VoiceVO {
    public let text: String
    public let command: VoiceCommandVO
    
    public init(text: String, command: VoiceCommandVO) {
        self.text = text
        self.command = command
    }
}

public enum VoiceCommandVO: Equatable {
    case next
    case previous
    case timer(minutes: Int, seconds: Int)
    case playVideo
    case stopVideo
    case stopTimer
    case unknown
}
