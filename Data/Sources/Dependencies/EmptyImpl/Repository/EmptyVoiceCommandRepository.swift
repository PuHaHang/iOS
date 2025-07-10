//
//  EmptyVoiceCommandRepository.swift
//  Data
//
//  Created by 디해 on 7/6/25.
//

import Foundation
import Domain
import Entity

struct EmptyVoiceCommandRepository: VoiceCommandRepository {
    func requestAuthorization() async -> Bool {
        throwUnimplemented()
    }
    
    func awaitVoiceCommand() async -> VoiceVO {
        throwUnimplemented()
    }
    
    func cancelRecognition() {
        throwUnimplemented()
    }
}
