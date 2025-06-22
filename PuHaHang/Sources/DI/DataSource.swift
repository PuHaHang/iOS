//
//  DataSource.swift
//  PuHaHang
//
//  Created by Jongchan Kim on 6/22/25.
//

import Foundation
import Dependencies

// MARK: - VersionDataSource DI

private enum VersionDataSourceKey: DependencyKey {
    static let liveValue: VersionDataSource = VersionDataSourceImpl()
    
    #if DEBUG
    static let testValue: VersionDataSource = MockVersionDataSourceImpl()
    #endif
    
    static let previewValue: VersionDataSource = MockVersionDataSourceImpl()
}

extension DependencyValues {
    var versionDataSource: VersionDataSource {
        get { self[VersionDataSourceKey.self] }
        set { self[VersionDataSourceKey.self] = newValue }
    }
}

