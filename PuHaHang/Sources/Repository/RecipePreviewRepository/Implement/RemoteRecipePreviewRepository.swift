//
//  RemoteRecipePreviewRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/21/25.
//

import Foundation

struct RemoteRecipePreviewRepository: RecipePreviewRepository {
    private let dataSource: RecipePreviewDataSource
    
    init(dataSource: RecipePreviewDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchPreview(for recipeID: UUID) async throws -> RecipePreview {
        let recipePreview = try await dataSource.fetchPreview(recipeID: recipeID)
        
        return recipePreview.toDomain()
    }
    
    func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreview] {
        let recipePreviews = try await dataSource.fetchPreviews(page: page, pageSize: pageSize)
        
        return recipePreviews.map { $0.toDomain() }
    }
}
