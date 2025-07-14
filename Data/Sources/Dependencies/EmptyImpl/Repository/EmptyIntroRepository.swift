//
//  EmptyIntroRepository.swift
//  Data
//
//  Created by 디해 on 7/2/25.
//

import Domain
import Entity
import Foundation

struct EmptyIntroRepository: IntroRepository {
    func fetchIntro() async throws -> IntroVO {
        throwUnimplemented()
    }
}
