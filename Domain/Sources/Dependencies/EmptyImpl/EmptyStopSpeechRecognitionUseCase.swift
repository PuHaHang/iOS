//
//  EmptyStopSpeechRecognitionUseCase.swift
//  Domain
//
//  Created by 디해 on 7/6/25.
//

import Foundation

struct EmptyStopSpeechRecognitionUseCase: StopSpeechRecognitionUseCase {
    func execute() {
        return unimplementedFailure()
    }
}
