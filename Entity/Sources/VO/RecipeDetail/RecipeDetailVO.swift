//
//  RecipeDetailVO.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import Foundation

public struct RecipeDetailVO {
    public let recipeID: UUID
    public let thumbnailURL: URL?
    public let title: String
    public let serving: Int
    public let reference: ReferenceVO
    public let ingredients: [IngredientVO]
    public let stages: [StageVO]
    
    public init(
        recipeID: UUID,
        thumbnailURL: URL?,
        title: String,
        serving: Int,
        reference: ReferenceVO,
        ingredients: [IngredientVO],
        stages: [StageVO]
    ) {
        self.recipeID = recipeID
        self.thumbnailURL = thumbnailURL
        self.title = title
        self.serving = serving
        self.reference = reference
        self.ingredients = ingredients
        self.stages = stages
    }
}
