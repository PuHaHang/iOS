//
//  RecipePreviewDataSource.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

protocol RecipePreviewDataSource {
    func fetchPreview(recipeID: String) async throws -> RecipePreviewDTO
}
