//
//  TitleTabBarItem.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import Shared
import SwiftUI

enum TitleTabBarItem: CaseIterable {
    case steps
    case ingredients
    
    var title: String {
        switch self {
        case .steps:
            LocalizationHelper.recipeStep
        case .ingredients:
            LocalizationHelper.recipeIngredient
        }
    }
}
