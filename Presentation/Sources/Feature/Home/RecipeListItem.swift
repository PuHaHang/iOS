//
//  RecipeListItem.swift
//  PuHaHang
//
//  Created by 디해 on 6/7/25.
//

import UIKit

struct RecipeListItem: Equatable {
    let recipeID: Int64
    let thumbnail: URL?
    let title: String
    let serving: String
    let ingredients: String
    let state: RecipeStateViewData
}
