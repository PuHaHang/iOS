//
//  Repository.swift
//  PuHaHang
//
//  Created by Jongchan Kim on 6/22/25.
//

import Foundation
import Domain
import Dependencies

// MARK: - IntroRepository DI

private enum IntroRepositoryKey: DependencyKey {
    static let liveValue: IntroRepository = {
        @Dependency(\.versionDataSource) var versionDataSource
        return IntroRepositoryImpl(dataSource: versionDataSource)
    }()
    
    #if DEBUG
    static let testValue: IntroRepository = {
        @Dependency(\.versionDataSource) var versionDataSource
        return IntroRepositoryImpl(dataSource: versionDataSource)
    }()
    #endif
    
    static let previewValue: IntroRepository = {
        @Dependency(\.versionDataSource) var versionDataSource
        return IntroRepositoryImpl(dataSource: versionDataSource)
    }()
}

extension DependencyValues {
    var introRepository: IntroRepository {
        get { self[IntroRepositoryKey.self] }
        set { self[IntroRepositoryKey.self] = newValue }
    }
}

