//
//  FetchRecipeStateUseCase.swift
//  Domain
//
//  Created by 디해 on 7/31/25.
//

import Foundation
import Entity

public protocol FetchRecipeStateUseCase {
    func execute(recipeID: Int64) async -> Result<RecipeStateVO, Error>
}
