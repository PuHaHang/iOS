//
//  RecipeDetailRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

protocol RecipeDetailRepository {
    func fetchDetail(for recipeID: UUID) async throws -> RecipeDetail
}
