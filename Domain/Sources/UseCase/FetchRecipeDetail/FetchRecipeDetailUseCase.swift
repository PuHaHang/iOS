//
//  FetchRecipeDetailUseCase.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity

public protocol FetchRecipeDetailUseCase {
    func execute(recipeID: Int64) async -> Result<RecipeDetailVO, Error>
}
