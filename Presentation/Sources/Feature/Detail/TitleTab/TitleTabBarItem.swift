//
//  TitleTabBarItem.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import SwiftUI

enum TitleTabBarItem: CaseIterable {
    case steps
    case ingredients
    
    var title: String {
        switch self {
        case .steps:
            "요리 단계"
        case .ingredients:
            "재료"
        }
    }
}
