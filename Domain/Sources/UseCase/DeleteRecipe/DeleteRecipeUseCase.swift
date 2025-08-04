//
//  DeleteRecipeUseCase.swift
//  Domain
//
//  Created by 디해 on 8/1/25.
//

import Foundation

public protocol DeleteRecipeUseCase {
    func execute(recipeID: Int64) async throws
}
