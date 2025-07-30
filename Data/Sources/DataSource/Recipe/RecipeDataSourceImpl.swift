//
//  RecipeDataSourceImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation
import Minifire

public struct RecipeDataSourceImpl: RecipeDataSource {
    public init() { }
    
    public func fetchRecipe(recipeID: Int64) async throws -> RecipeDTO {
        let request = MFRequest(url: "https://domain.com/v1/recipe")
            .validate()
            .addQueries(["recipe_id": UUID(uuidString: "123e4567-e89b-12d3-a456-426614174000")!])
        let response = try await MF.requestDecodable(of: RecipeDTO.self, request)
        
        return response.value
    }
    
    public func generateRecipe(from source: String) async throws -> RecipeConversionDTO {
        guard let localToken = loginManager.loadLocalToken() else { throw DataSourceError.unauthorized }
        
        let request = MFRequest(url: "http://121.157.24.40/api/v1/recipe")
            .post()
            .validate()
            .addParameters(["source": source])
            .addHeaders([.authorization(bearerToken: localToken)])
        
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestDecodable(of: RecipeConversionDTO.self, request)
        
        return response.value
    }
        
        return response.value
    }
}
