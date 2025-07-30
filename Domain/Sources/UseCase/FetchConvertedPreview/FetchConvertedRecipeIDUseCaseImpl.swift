//
//  FetchConvertedPreviewUseCaseImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import Foundation

public struct FetchConvertedRecipeIDUseCaseImpl: FetchConvertedRecipeIDUseCase {
    private let recipeConversionRepository: RecipeConversionRepository
    
    public init(recipeConversionRepository: RecipeConversionRepository) {
        self.recipeConversionRepository = recipeConversionRepository
    }
    
    public func execute(_ source: String) async -> Result<Int64, Error> {
        do {
            let recipeID = try await recipeConversionRepository.convert(from: source)
            return .success(recipeID)
        } catch {
            return .failure(error)
        }
    }
}
