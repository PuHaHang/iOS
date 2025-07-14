//
//  RequestVoiceAuthorizationUseCase.swift
//  Domain
//
//  Created by 디해 on 7/6/25.
//

import Foundation

public protocol RequestVoiceAuthorizationUseCase {
    func execute() async -> Bool
}
