//
//  MockIntroDataSource.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation
import Minifire

final class MockIntroDataSource: IntroDataSource {
    func fetchVersionRequirement() async throws -> VersionRequirementDTO {
        let request = MFRequest(url: "http://121.157.24.40/v1/intro")
        let response = try await MF.requestDecodable(of: VersionRequirementDTO.self, request)
        
        guard response.httpResponse?.statusCode == 200 else {
            throw LocalError(message: "Error: Invalid status code")
        }
        
        return response.value
    }
}
