//
//  RecipePreviewDataSourceImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/21/25.
//

import Foundation
import Minifire

struct RecipePreviewDataSourceImpl: RecipePreviewDataSource {
    func fetchPreview(recipeID: UUID) async throws -> RecipePreviewDTO {
        let request = MFRequest(url: "https://domain.com/v1/recipe_list")
            .addQueries(["recipe_id": UUID(uuidString: "123e4567-e89b-12d3-a456-426614174000")!])
        let response = try await MF.requestDecodable(of: RecipePreviewDTO.self, request)
        
        return response.value
    }
    
    func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreviewDTO] {
        let request = MFRequest(url: "https://domain.com/v1/recipe_list")
        request.addQueries(["page": 1, "size": 50])
        let response = try await MF.requestDecodable(of: [RecipePreviewDTO].self, request)
        
        return response.value
    }
}
