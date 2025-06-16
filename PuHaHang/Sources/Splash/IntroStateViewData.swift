//
//  IntroRoadState.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation

enum IntroStateViewData {
    case idle
    case success(IntroViewData)
    case failure(Error)
}
