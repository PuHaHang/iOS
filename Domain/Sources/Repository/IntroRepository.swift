//
//  IntroRepository.swift
//  Domain
//
//  Created by Jongchan Kim on 6/22/25.
//

import Foundation
import Entity

public protocol IntroRepository {
    func fetchIntro() async throws -> IntroVO
}
