//
//  LiveIntroRepository.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation

struct TemporaryIntroRepository: IntroRepository {
    private let dataSource: VersionRemoteDataSource
    
    init(dataSource: VersionRemoteDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchIntro() async throws -> Intro {
        let versionRequirement = try await dataSource.fetchVersionRequirement()
        return versionRequirement.toDomain()
    }
}
