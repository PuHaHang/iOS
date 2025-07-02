//
//  RecipePreviewVO.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

public struct RecipePreviewVO {
    public let recipeID: UUID
    public let thumbnailURL: URL?
    public let title: String
    public let serving: Int
    public let ingredients: [IngredientVO]
    
    public init(
        recipeID: UUID,
        thumbnailURL: URL?,
        title: String,
        serving: Int,
        ingredients: [IngredientVO]
    ) {
        self.recipeID = recipeID
        self.thumbnailURL = thumbnailURL
        self.title = title
        self.serving = serving
        self.ingredients = ingredients
    }
}
