//
//  RecipeListDTO.swift
//  Data
//
//  Created by 디해 on 8/3/25.
//

import Entity
import Foundation

public struct RecipeListDTO: Codable {
    let recipes: [RecipePreviewDTO]
    let hasNext: Bool
    let cursorId: Int?
}

extension RecipeListDTO {
    func toDomain() -> RecipeListVO {
        return RecipeListVO(
            previews: recipes.map { $0.toDomain() },
            hasNext: hasNext,
            cursorId: cursorId
        )
    }
}
