//
//  RemoteRecipeDetailRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation
import Entity
import Domain

struct RecipeDetailRepositoryImpl: RecipeDetailRepository {
    private let dataSource: RecipeDataSource
    
    init(dataSource: RecipeDataSource) {
        self.dataSource = dataSource
    }

    func fetchDetail(for recipeID: UUID) async throws -> RecipeDetailVO {
        let recipe = try await dataSource.fetchRecipe(recipeID: recipeID)
        
        return recipe.toDomain()
    }
}
