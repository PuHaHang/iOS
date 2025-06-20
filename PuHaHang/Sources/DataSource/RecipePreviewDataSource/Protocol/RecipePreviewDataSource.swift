//
//  RecipePreviewDataSource.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

protocol RecipePreviewDataSource {
    func fetchPreview(recipeID: UUID) async throws -> RecipePreviewDTO
    func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreviewDTO]
}
