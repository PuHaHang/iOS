//
//  ErrorRecipeDetailRepositoryImpl.swift
//  Data
//
//  Created by 디해 on 8/3/25.
//

import Domain
import Entity
import Foundation

public enum RecipeDetailError: Error {
    case forcedFailure
}

public struct ErrorRecipeDetailRepositoryImpl: RecipeDetailRepository {
    public init() { }
    
    public func fetchDetail(for recipeID: Int64) async throws -> Entity.RecipeDetailVO {
        throw RecipeDetailError.forcedFailure
    }
    
    public func delete(for recipeID: Int64) async throws {
        throw RecipeDetailError.forcedFailure
    }
}
