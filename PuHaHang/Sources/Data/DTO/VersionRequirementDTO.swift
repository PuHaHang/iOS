//
//  VersionRequirementDTO.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation
import Entity

public struct VersionRequirementDTO: Decodable {
    let recommendVersion: String
    let minVersion: String
}

public extension VersionRequirementDTO {
    func toDomain() -> IntroVO {
        return IntroVO(
            recommendVersion: recommendVersion,
            minVersion: minVersion
        )
    }
}
