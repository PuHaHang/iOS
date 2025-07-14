//
//  GetVoiceCommandStreamUseCase.swift
//  Domain
//
//  Created by 디해 on 7/6/25.
//

import Entity
import Foundation

public protocol ReceiveVoiceCommandUseCase {
    func execute() async -> Result<VoiceVO, Error>
}
