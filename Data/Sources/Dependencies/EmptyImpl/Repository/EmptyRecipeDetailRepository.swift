//
//  EmptyRecipeDetailRepository.swift
//  Data
//
//  Created by 디해 on 7/2/25.
//

import Domain
import Entity
import Foundation

struct EmptyRecipeDetailRepository: RecipeDetailRepository {
    func fetchDetail(for recipeID: Int64) async throws -> Entity.RecipeDetailVO {
        throwUnimplemented()
    }
    
    func delete(for recipeID: Int64) async throws {
        throwUnimplemented()
    }
}
