//
//  TimelineVO.swift
//  Entity
//
//  Created by 디해 on 7/4/25.
//

import Foundation

public struct TimelineVO {
    public let startTime: Double
    public let endTime: Double
    
    public init(startTime: Double, endTime: Double) {
        self.startTime = startTime
        self.endTime = endTime
    }
}
