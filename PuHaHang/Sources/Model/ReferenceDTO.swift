//
//  ReferenceDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation

struct ReferenceDTO: Decodable {
    let platform: String
    let content: String
}

extension ReferenceDTO {
    func toDomain() -> Reference {
        Reference.from(type: platform, value: content)
    }
}
