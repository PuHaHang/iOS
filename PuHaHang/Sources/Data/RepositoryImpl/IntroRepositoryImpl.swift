//
//  LiveIntroRepository.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation
import Domain
import Entity

struct IntroRepositoryImpl: IntroRepository {
    private let dataSource: VersionDataSource
    
    init(dataSource: VersionDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchIntro() async throws -> IntroVO {
        let versionRequirement = try await dataSource.fetchVersionRequirement()
        return versionRequirement.toDomain()
    }
}
