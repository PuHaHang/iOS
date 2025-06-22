//
//  IngredientDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity

public struct IngredientDTO: Decodable {
    let id: UUID
    let ingredient: String
    let amount: String
}

extension IngredientDTO {
    func toDomain() -> IngredientVO {
        return IngredientVO(
            id: id,
            name: ingredient,
            amount: amount
        )
    }
}
