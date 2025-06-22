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
    let externalLink: URL?
    let steps: [RecipeStepViewData]
    let ingredients: [IngredientViewData]
    
    var hasExternalLink: Bool {
        externalLink != nil
    }
}
