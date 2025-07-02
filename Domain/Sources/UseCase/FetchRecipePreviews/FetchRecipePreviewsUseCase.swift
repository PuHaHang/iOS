//
//  FetchRecipePreviewsUseCase.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity

public protocol FetchRecipePreviewsUseCase {
    func execute(page: Int, pageSize: Int) async -> Result<[RecipePreviewVO], Error>
}
