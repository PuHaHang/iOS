//
//  LiveIntroRepository.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation
import Domain
import Entity

public struct IntroRepositoryImpl: IntroRepository {
    private let dataSource: VersionDataSource
    
    public init(dataSource: VersionDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchIntro() async throws -> IntroVO {
        let versionRequirement = try await dataSource.fetchVersionRequirement()
        return versionRequirement.toDomain()
    }
}
