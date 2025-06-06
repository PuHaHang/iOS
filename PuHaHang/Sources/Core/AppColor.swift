//
//  AppColor.swift
//  PuHaHang
//
//  Created by 디해 on 6/7/25.
//

import SwiftUI

enum AppColor {
    static let main = Color("main")
}

extension AppColor {
    enum Component {
        static let plusButton = Color("main")
    }
    
    enum TabBar {
        static let activeButton = Color("main")
        static let inactiveButton = Color("tab_bar_inactive")
    }
}
