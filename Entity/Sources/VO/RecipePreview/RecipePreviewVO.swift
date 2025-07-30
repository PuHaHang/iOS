//
//  RecipePreviewVO.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

public struct RecipePreviewVO {
    public let recipeID: Int64
    public let thumbnailURL: URL?
    public let title: String
    public let servings: Int
    public let ingredients: [IngredientVO]
    public let state: RecipeStateVO
    
    public init(
        recipeID: Int64,
        thumbnailURL: URL?,
        title: String,
        servings: Int,
        ingredients: [IngredientVO],
        state: String
    ) {
        self.recipeID = recipeID
        self.thumbnailURL = thumbnailURL
        self.title = title
        self.servings = servings
        self.ingredients = ingredients
        self.state = RecipeStateVO(rawValue: state)
    }
}
