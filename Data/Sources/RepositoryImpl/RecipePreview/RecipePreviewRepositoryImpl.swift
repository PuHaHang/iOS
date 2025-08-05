//
//  RemoteRecipePreviewRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/21/25.
//

import Foundation
import Entity
import Domain

public struct RecipePreviewRepositoryImpl: RecipePreviewRepository {
    private let dataSource: RecipePreviewDataSource
    
    public init(dataSource: RecipePreviewDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchPreview(for recipeID: Int64) async throws -> RecipePreviewVO {
        let recipePreview = try await dataSource.fetchPreview(recipeID: recipeID)
        return recipePreview.toDomain()
    }
    
    public func fetchPreviews(cursorId: Int?, size: Int, fromCache: Bool = false) async throws -> RecipeListVO {
        let recipeList = try await dataSource.fetchPreviews(cursorId: cursorId, size: size, fromCache: fromCache)
        return recipeList.toDomain()
    }
}
