//
//  EmptyReceiveVoiceCommandUseCase.swift
//  Domain
//
//  Created by 디해 on 7/6/25.
//

import Entity
import Foundation

struct EmptyReceiveVoiceCommandUseCase: ReceiveVoiceCommandUseCase {
    func execute() async -> Result<VoiceVO, Error> {
        return unimplementedFailure()
    }
}
