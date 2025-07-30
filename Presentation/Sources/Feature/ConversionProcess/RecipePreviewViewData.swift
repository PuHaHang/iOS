//
//  RecipePreviewViewData.swift
//  Presentation
//
//  Created by 디해 on 7/12/25.
//

import UIKit

struct RecipePreviewViewData: Equatable {
    let recipeID: Int64
    let thumbnail: URL?
    let title: String
    let serving: String
    let steps: [RecipeStepViewData]
    let state: RecipeStateViewData
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.recipeID == rhs.recipeID
    }
}
