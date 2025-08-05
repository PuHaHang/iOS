//
//  RecipePreviewRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity

public protocol RecipePreviewRepository {
    func fetchPreview(for recipeID: Int64) async throws -> RecipePreviewVO
    func fetchPreviews(cursorId: Int?, size: Int, fromCache: Bool) async throws -> RecipeListVO
    func clearCache() async throws
}
