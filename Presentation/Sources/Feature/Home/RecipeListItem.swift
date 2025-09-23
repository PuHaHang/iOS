//
//  RecipeListItem.swift
//  PuHaHang
//
//  Created by 디해 on 6/7/25.
//

import Shared
import UIKit

struct RecipeListItem: Equatable {
    let recipeID: Int64
    let thumbnail: URL?
    let title: String
    let servings: Int
    let ingredients: String
    let state: RecipeStateViewData
    
    var serving: String {
        "\(self.servings)\(LocalizationHelper.recipeServingUnit)"
    }
}
