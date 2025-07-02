//
//  EmptyVersionDataSource.swift
//  Data
//
//  Created by 디해 on 7/2/25.
//

import Foundation

public struct EmptyVersionDataSource: VersionDataSource {
    public func fetchVersionRequirement() async throws -> VersionRequirementDTO {
        throwUnimplemented()
    }
}
