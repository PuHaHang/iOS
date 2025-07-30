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
    
    public func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreviewVO] {
        let recipePreviews = try await dataSource.fetchPreviews(page: page, pageSize: pageSize)
        
        return recipePreviews.map { $0.toDomain() }
    }
}
