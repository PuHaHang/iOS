//
//  TestIntroUseCase.swift
//  Domain
//
//  Created by 디해 on 7/2/25.
//

import Entity
import Foundation

struct EmptyIntroUseCase: IntroUseCase {
    func execute() async -> Result<IntroVO, any Error> {
        return unimplementedFailure()
    }
}
