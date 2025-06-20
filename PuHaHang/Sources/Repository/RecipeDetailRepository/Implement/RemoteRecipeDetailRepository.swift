//
//  RemoteRecipeDetailRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation

struct RemoteRecipeDetailRepository: RecipeDetailRepository {
    private let dataSource: RecipeDataSource
    
    init(dataSource: RecipeDataSource) {
        self.dataSource = dataSource
    }

    func fetchDetail(for recipeID: UUID) async throws -> RecipeDetail {
        let recipe = try await dataSource.fetchRecipe(recipeID: recipeID)
        
        return recipe.toDomain()
    }
}
