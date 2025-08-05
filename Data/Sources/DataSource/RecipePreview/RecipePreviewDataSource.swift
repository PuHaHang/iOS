//
//  RecipePreviewDataSource.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

public protocol RecipePreviewDataSource {
    func fetchPreview(recipeID: Int64) async throws -> RecipePreviewDTO
    func fetchPreviews(cursorId: Int?, size: Int, fromCache: Bool) async throws -> RecipeListDTO
}
