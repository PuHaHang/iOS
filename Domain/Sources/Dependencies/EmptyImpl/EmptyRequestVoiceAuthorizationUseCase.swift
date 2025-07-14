//
//  EmptyRequestVoiceAuthorizationUseCase.swift
//  Domain
//
//  Created by 디해 on 7/6/25.
//

import Foundation

struct EmptyRequestVoiceAuthorizationUseCase: RequestVoiceAuthorizationUseCase {
    func execute() async -> Bool {
        return unimplementedFailure()
    }
}
