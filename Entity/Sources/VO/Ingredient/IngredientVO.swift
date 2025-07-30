//
//  IngredientVO.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import Foundation

public struct IngredientVO {
    public let id: Int64
    public let name: String
    public let amount: String
    
    public init(
        id: Int64,
        name: String,
        amount: String
    ) {
        self.id = id
        self.name = name
        self.amount = amount
    }
}
