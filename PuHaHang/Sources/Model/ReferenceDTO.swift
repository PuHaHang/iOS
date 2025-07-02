//
//  ReferenceDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation
import Entity

struct ReferenceDTO: Decodable {
    let platform: String
    let content: String
}

extension ReferenceDTO {
    func toDomain() -> ReferenceVO {
        ReferenceVO.from(type: platform, value: content)
    }
}
