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

    func execute(page: Int, pageSize: Int) async -> Result<[RecipePreviewVO], any Error> {
        unimplementedFailure()
    }
}
