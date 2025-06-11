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
        static let plusButton = AppColor.main
        static let disabledButton = Color("button_disabled")
    }
    
    enum TabBar {
        static let activeButton = AppColor.main
        static let inactiveButton = Color("tab_bar_inactive")
    }
    
    enum Text {
        static let main = Color("text_main")
        static let serving = Color("text_serving")
        static let ingredients = Color("text_ingredients")
        static let information = Color("text_info")
    }
}
