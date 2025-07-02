//
//  EmptyRecipeConversionRepository.swift
//  Data
//
//  Created by 디해 on 7/2/25.
//

import Domain
import Foundation

struct EmptyRecipeConversionRepository: RecipeConversionRepository {
    func convert(from input: String) async throws -> UUID {
        throwUnimplemented()
    }
}
