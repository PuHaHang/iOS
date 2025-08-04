//
//  ErrorRecipeConversionRepositoryImpl.swift
//  Data
//
//  Created by 디해 on 8/3/25.
//

import Domain
import Entity
import Foundation

public enum RecipeConversionError: Error {
    case forcedFailure
}

public struct ErrorRecipeConversionRepositoryImpl: RecipeConversionRepository {
    
    public init() { }
    
    public func convert(from input: String) async throws -> Int64 {
        throw RecipeConversionError.forcedFailure
    }
    
    public func fetchState(of recipeID: Int64) async throws -> RecipeStateVO {
        throw RecipeConversionError.forcedFailure
    }
    
    public func filterCompletedConversionRecipeIDs(from ids: [Int64]) async throws -> [Int64] {
        throw RecipeConversionError.forcedFailure
    }
    
    
}
