//
//  RecipeDetailRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity

public protocol RecipeDetailRepository {
    func fetchDetail(for recipeID: Int64) async throws -> RecipeDetailVO
}
