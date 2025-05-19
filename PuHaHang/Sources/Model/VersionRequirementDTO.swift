//
//  VersionRequirementDTO.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation

struct VersionRequirementDTO: Decodable {
    let recommendVersion: String
    let minVersion: String
}

extension VersionRequirementDTO {
    func toDomain() -> Intro {
        return Intro(
            recommendVersion: recommendVersion,
            minVersion: minVersion
        )
    }
}
