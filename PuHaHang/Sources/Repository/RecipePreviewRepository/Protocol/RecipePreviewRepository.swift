//
//  RecipePreviewRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

protocol RecipePreviewRepository {
    func fetchPreview(for recipeID: String) async throws -> RecipePreview
    func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreview]
}
