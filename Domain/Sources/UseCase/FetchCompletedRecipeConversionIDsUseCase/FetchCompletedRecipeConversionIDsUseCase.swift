//
//  FetchCompletedRecipeConversionIDsUseCase.swift
//  Domain
//
//  Created by 디해 on 7/27/25.
//

import Foundation

public protocol FetchCompletedRecipeConversionIDsUseCase {
    func execute(ids: [Int64]) async throws -> [Int64]
}
