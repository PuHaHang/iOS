//
//  Recipe.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import Foundation

struct RecipeDetail {
    let recipeID: UUID
    let thumbnailURL: URL?
    let title: String
    let serving: Int
    let ingredients: [Ingredient]
    let stages: [Stage]
}
