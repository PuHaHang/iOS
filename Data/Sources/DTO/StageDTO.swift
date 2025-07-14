//
//  StageDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation
import Entity

public struct StageDTO: Decodable {
    let step: Int
    let startTime: Double
    let endTime: Double
    let description: String
}

extension StageDTO {
    func toDomain() -> StageVO {
        return StageVO(
            step: step,
            timeline: TimelineVO(
                startTime: startTime,
                endTime: endTime
            ),
            instruction: description
        )
    }
}
