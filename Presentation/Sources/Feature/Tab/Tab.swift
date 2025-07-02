//
//  Tab.swift
//  PuHaHang
//
//  Created by 디해 on 6/5/25.
//

import Foundation

enum Tab {
    case home
    case setting
}

extension Tab {
    var icon: String {
        switch self {
        case .home:
            "house.fill"
        case .setting:
            "gearshape.fill"
        }
    }
}
