//
//  Intro.swift
//  Entity
//
//  Created by Jongchan Kim on 6/22/25.
//

import Foundation

public struct IntroVO {
    public let recommendVersion: String
    public let minVersion: String
    
    public init(recommendVersion: String, minVersion: String) {
        self.recommendVersion = recommendVersion
        self.minVersion = minVersion
    }
}
