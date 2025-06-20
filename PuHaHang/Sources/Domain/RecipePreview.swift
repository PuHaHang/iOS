//
//  RecipePreview.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

struct RecipePreview {
    let recipeID: UUID
    let thumbnailURL: URL?
    let title: String
    let serving: Int
    let ingredients: [Ingredient]
}
