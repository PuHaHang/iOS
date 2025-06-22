//
//  RecipePreviewDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity

public struct RecipePreviewDTO: Decodable {
    let recipeID: UUID
    let thumbnail: String
    let title: String
    let serving: Int
    let ingredients: [IngredientDTO]
    let state: Int
    
    enum CodingKeys: String, CodingKey {
        case recipeID = "recipe_id"
        case thumbnail
        case title
        case serving
        case ingredients
        case state
    }
}

extension RecipePreviewDTO {
    func toDomain() -> RecipePreviewVO {
        let url = URL(string: thumbnail)
        let ingredients = ingredients.map { $0.toDomain() }
        
        return RecipePreviewVO(
            recipeID: recipeID,
            thumbnailURL: url,
            title: title,
            serving: serving,
            ingredients: ingredients
        )
    }
}
