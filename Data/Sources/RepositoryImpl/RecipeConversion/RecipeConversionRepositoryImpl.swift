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
    
    public func convert(from input: String) async throws -> Int64 {
        let recipeID = try await dataSource.generateRecipe(from: input).recipeID
        return recipeID
    }
    
    public func filterCompletedConversionRecipeIDs(from ids: [Int64]) async throws -> [Int64] {
        try await dataSource.filterCompletedRecipeIDs(from: ids).recipes
    }
}
