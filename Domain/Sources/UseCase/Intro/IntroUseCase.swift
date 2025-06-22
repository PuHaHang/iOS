//
//  LiveFetchIntroUseCase.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import Foundation
import Entity

public protocol IntroUseCase {
    func execute() async -> Result<IntroVO, Error>
}

public struct IntroUseCaseImpl: IntroUseCase {
    private let introRepository: IntroRepository
    
    public init(introRepository: IntroRepository) {
        self.introRepository = introRepository
    }
    
    public func execute() async -> Result<IntroVO, Error> {
        do {
            let intro = try await introRepository.fetchIntro()
            return .success(intro)
        } catch {
            return .failure(error)
        }
    }
}
