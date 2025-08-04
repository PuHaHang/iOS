//
//  EmptyDeleteRecipeUseCase.swift
//  Domain
//
//  Created by 디해 on 8/1/25.
//

import Foundation

struct EmptyDeleteRecipeUseCase: DeleteRecipeUseCase {
    func execute(recipeID: Int64) async throws {
        unimplementedFailure()
    }
}
