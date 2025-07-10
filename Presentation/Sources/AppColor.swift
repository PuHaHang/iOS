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
        static let highlight = AppColor.main
        static let serving = Color("text_serving")
        static let ingredients = Color("text_ingredients")
        static let information = Color("text_info")
        static let emptyList = Color("text_empty_list")
        static let step = Color("text_step")
        static let normalInstruction = Color("text_instruction_normal")
        static let highlightedInstruction = AppColor.main
        static let validVoice = Color("text_voice_valid")
        static let invalidVoice = Color("text_voice_invalid")
    }
    
    enum IngredientTodo {
        static let background = Color("background")
        static let checkedIcon = AppColor.main
        static let uncheckedIcon = Color("icon_unchecked")
        static let checkedText = Color("text_checked")
        static let uncheckedText = AppColor.Text.main
    }
    
    enum Voice {
        static let validBackground = Color("voice_background_valid")
        static let invalidBackground = Color("voice_background_invalid")
    }
}
