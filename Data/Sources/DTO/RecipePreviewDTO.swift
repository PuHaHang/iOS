//
//  RecipePreviewDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity

public struct RecipePreviewDTO: Decodable {
    let recipeID: Int64
    let title: String?
    let thumbnail: String?
    let servings: Int?
    let ingredients: [IngredientDTO]?
    let state: String
    
    enum CodingKeys: String, CodingKey {
        case recipeID = "recipeId"
        case title
        case thumbnail
        case servings
        case ingredients
        case state
    }
}

extension RecipePreviewDTO {
    func toDomain() -> RecipePreviewVO {
        var url: URL?
        if let thumbnail { url = URL(string: thumbnail) }
        
        var ingredientVOs: [IngredientVO] = []
        if let ingredients { ingredientVOs = ingredients.map { $0.toDomain()} }
        
        return RecipePreviewVO(
            recipeID: recipeID,
            thumbnailURL: url,
            title: title ?? "",
            servings: servings ?? 0,
            ingredients: ingredientVOs,
            state: state
        )
    }
}
