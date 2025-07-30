//
//  RecipeConversionDTO .swift
//  Data
//
//  Created by 디해 on 7/27/25.
//

import Foundation

public struct RecipeConversionDTO: Decodable {
    let recipeID: Int64
    
    enum CodingKeys: String, CodingKey {
        case recipeID = "recipeId"
    }
}
