//
//  EmptyFetchRecipePreviewsUseCase.swift
//  Domain
//
//  Created by 디해 on 7/2/25.
//

import Entity
import Foundation

struct EmptyFetchRecipePreviewsUseCase: FetchRecipePreviewsUseCase {
    init() {}

    func execute(cursorId: Int?, size: Int) async -> Result<RecipeListVO, Error> {
        unimplementedFailure()
    }
}
