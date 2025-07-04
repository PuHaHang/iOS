//
//  StageVO.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import Foundation

public struct StageVO {
    public let step: Int
    public let timeline: TimelineVO
    public let instruction: String
    
    public init(
        step: Int,
        timeline: TimelineVO,
        instruction: String
    ) {
        self.step = step
        self.timeline = timeline
        self.instruction = instruction
    }
}
