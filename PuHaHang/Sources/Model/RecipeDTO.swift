//
//  RecipeDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation

struct RecipeDTO: Decodable {
    let id: UUID
    let thumbnail: String
    let title: String
    let serving: Int
    let reference: ReferenceDTO
    let ingredients: [IngredientDTO]
    let stages: [StageDTO]
}
