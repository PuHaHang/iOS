//
//  IngredientDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity

public struct IngredientDTO: Codable {
    let id: Int64
    let name: String
    let amount: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ingredient_id"
        case name
        case amount
    }
}

extension IngredientDTO {
    func toDomain() -> IngredientVO {
        return IngredientVO(
            id: id,
            name: name,
            amount: amount
        )
    }
}
