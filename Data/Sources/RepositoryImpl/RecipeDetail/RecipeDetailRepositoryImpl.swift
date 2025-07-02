//
//  RemoteRecipeDetailRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation
import Entity
import Domain

public struct RecipeDetailRepositoryImpl: RecipeDetailRepository {
    private let dataSource: RecipeDataSource
    
    public init(dataSource: RecipeDataSource) {
        self.dataSource = dataSource
    }

    public func fetchDetail(for recipeID: UUID) async throws -> RecipeDetailVO {
        let recipe = try await dataSource.fetchRecipe(recipeID: recipeID)
        
        return recipe.toDomain()
    }
}
