//
//  RemoteRecipePreviewRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/21/25.
//

import Foundation
import Entity
import Domain

struct RecipePreviewRepositoryImpl: RecipePreviewRepository {
    private let dataSource: RecipePreviewDataSource
    
    init(dataSource: RecipePreviewDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchPreview(for recipeID: UUID) async throws -> RecipePreviewVO {
        let recipePreview = try await dataSource.fetchPreview(recipeID: recipeID)
        
        return recipePreview.toDomain()
    }
    
    func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreviewVO] {
        let recipePreviews = try await dataSource.fetchPreviews(page: page, pageSize: pageSize)
        
        return recipePreviews.map { $0.toDomain() }
    }
}
