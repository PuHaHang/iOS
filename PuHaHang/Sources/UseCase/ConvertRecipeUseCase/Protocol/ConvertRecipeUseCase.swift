//
//  ConvertRecipeUseCase.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import Foundation

protocol FetchConvertedPreviewUseCase {
    func execute(_ source: String) async -> Result<RecipePreview, Error>
}
