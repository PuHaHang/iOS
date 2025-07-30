//
//  RecipeViewData.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import UIKit

struct RecipeViewData {
    let recipeID: Int64
    let title: String
    let thumbnail: URL?
    let serving: String
    let reference: ReferenceViewData
    let steps: [RecipeStepViewData]
    let ingredients: [IngredientViewData]
}
