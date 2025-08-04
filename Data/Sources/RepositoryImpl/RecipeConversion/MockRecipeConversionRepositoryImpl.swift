//
//  MockRecipeConversionRepositoryImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity
import Domain

public struct MockRecipeConversionRepositoryImpl: RecipeConversionRepository {
    public init() { }
    
    public func convert(from input: String) async throws -> Int64 {
        return 0
    }
    
    public func fetchState(of recipeID: Int64) async throws -> RecipeStateVO {
        return .completed
    }
    
    public func filterCompletedConversionRecipeIDs(from ids: [Int64]) async throws -> [Int64] {
        return [1]
    }
}
