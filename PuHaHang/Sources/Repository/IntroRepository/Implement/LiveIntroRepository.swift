//
//  LiveIntroRepository.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation

struct LiveIntroRepository: IntroRepository {
    private let dataSource: IntroDataSource
    
    init(dataSource: IntroDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchIntro() async throws -> Intro {
        let versionRequirement = try await dataSource.fetchVersionRequirement()
        return versionRequirement.toDomain()
    }
}
