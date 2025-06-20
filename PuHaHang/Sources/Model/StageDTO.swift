//
//  StageDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation

struct StageDTO: Decodable {
    let step: Int
    let timeline: Double
    let description: String
}

extension StageDTO {
    func toDomain() -> Stage {
        return Stage(
            step: step,
            timeline: timeline,
            instruction: description
        )
    }
}
