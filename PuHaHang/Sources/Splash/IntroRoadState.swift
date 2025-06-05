//
//  IntroRoadState.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation

enum IntroRoadState {
    case idle
    case success(Intro)
    case failure(Error)
}
