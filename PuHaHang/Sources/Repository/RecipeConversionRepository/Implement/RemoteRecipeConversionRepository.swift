//
//  RemoteRecipeConversionRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/21/25.
//

import Foundation

struct RemoteRecipeConversionRepository: RecipeConversionRepository {
    private let dataSource: RecipeDataSource
    
    init(dataSource: RecipeDataSource) {
        self.dataSource = dataSource
    }
    
    func convert(from input: String) async throws -> UUID {
        let recipeID = try await dataSource.generateRecipe(from: input)
        return recipeID
    }
}
