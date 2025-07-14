//
//  RecipeViewData.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import UIKit

struct RecipeViewData {
    let recipeID: UUID
    let title: String
    let thumbnail: UIImage
    let serving: String
    let reference: ReferenceViewData
    let steps: [RecipeStepViewData]
    let ingredients: [IngredientViewData]
}
