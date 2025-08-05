//
//  ErrorRecipePreviewRepositoryImpl.swift
//  Data
//
//  Created by 디해 on 8/3/25.
//

import Domain
import Entity
import Foundation

public enum RecipePreviewError: Error {
    case forcedFailure
}

public struct ErrorRecipePreviewRepositoryImpl: RecipePreviewRepository {
    public init() { }
    
    public func fetchPreview(for recipeID: Int64) async throws -> RecipePreviewVO {
        throw RecipePreviewError.forcedFailure
    }
    
    public func fetchPreviews(cursorId: Int?, size: Int, fromCache: Bool) async throws -> Entity.RecipeListVO {
        throw RecipePreviewError.forcedFailure
    }
}
