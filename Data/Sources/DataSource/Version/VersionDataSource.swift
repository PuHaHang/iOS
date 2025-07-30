//
//  VersionRemoteDataSourceImpl.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation
import Minifire

public protocol VersionDataSource {
    func fetchVersionRequirement() async throws -> VersionRequirementDTO
}

public struct VersionDataSourceImpl: VersionDataSource {
    public init() { }
    
    public func fetchVersionRequirement() async throws -> VersionRequirementDTO {
        let request = MFRequest(url: "http://121.157.24.40/api/v1/intro").validate()
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestDecodable(of: VersionRequirementDTO.self, request)
        
        return response.value
    }
}

public struct MockVersionDataSourceImpl: VersionDataSource {
    public init() { }
    
    public func fetchVersionRequirement() async throws -> VersionRequirementDTO {
        return VersionRequirementDTO(
            recommendVersion: "mock mock - 2.2.2",
            minVersion: "mock mock - 1.1.1"
        )
    }
}
