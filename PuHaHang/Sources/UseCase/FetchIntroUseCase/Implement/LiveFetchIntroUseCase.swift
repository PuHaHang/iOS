//
//  LiveFetchIntroUseCase.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import Foundation

struct LiveFetchIntroUseCase: FetchIntroUseCase {
    private let versionRepository: IntroRepository
    
    init(versionRepository: IntroRepository) {
        self.versionRepository = versionRepository
    }
    
    func execute() async -> Result<Intro, Error> {
        do {
            let intro = try await versionRepository.fetchIntro()
            return .success(intro)
        } catch {
            return .failure(error)
        }
    }
}
