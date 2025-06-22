//
//  RemoteRecipeConversionRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/21/25.
//

import Foundation
import Domain

public struct RecipeConversionRepositoryImpl: RecipeConversionRepository {
    private let dataSource: RecipeDataSource
    
    public init(dataSource: RecipeDataSource) {
        self.dataSource = dataSource
    }
    
    public func convert(from input: String) async throws -> UUID {
        let recipeID = try await dataSource.generateRecipe(from: input)
        return recipeID
    }
}
