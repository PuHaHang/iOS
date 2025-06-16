//
//  RecipePreviewDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

struct RecipePreviewDTO: Decodable {
    let recipeID: String
    let thumbnailURL: URL
    let title: String
    let serving: Int
    let ingredients: [IngredientDTO]
}
