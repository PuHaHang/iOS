//
//  RecipeDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation
import Entity

public struct RecipeDTO: Decodable {
    let id: UUID
    let thumbnail: String
    let title: String
    let serving: Int
    let reference: ReferenceDTO
    let ingredients: [IngredientDTO]
    let stages: [StageDTO]
}

extension RecipeDTO {
    func toDomain() -> RecipeDetailVO {
        let url = URL(string: thumbnail)
        let ingredients = ingredients.map { $0.toDomain() }
        let stages = stages.map { $0.toDomain() }
        
        return RecipeDetailVO(
            recipeID: id,
            thumbnailURL: url,
            title: title,
            serving: serving,
            reference: reference.toDomain(),
            ingredients: ingredients,
            stages: stages
        )
    }
}
