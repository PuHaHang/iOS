//
//  RecipeDataSourceImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation
import Minifire

struct RecipeDataSourceImpl: RecipeDataSource {
    func fetchRecipe(recipeID: String) async throws -> RecipeDTO {
        let request = MFRequest(url: "https://domain.com/v1/recipe")
        request.addQueries(["recipe_id": UUID(uuidString: "123e4567-e89b-12d3-a456-426614174000")!])
        let response = try await MF.requestDecodable(of: RecipeDTO.self, request)
        
        return response.value
    }
}
