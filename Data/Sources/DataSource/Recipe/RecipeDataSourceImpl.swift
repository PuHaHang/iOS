//
//  RecipeDataSourceImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Dependencies
import Foundation
import Minifire
import Login

public struct RecipeDataSourceImpl: RecipeDataSource {
    @Dependency(\.loginManager) var loginManager
    
    public init() { }
    
    public func fetchRecipe(recipeID: Int64) async throws -> RecipeDTO {
        guard let localToken = loginManager.loadLocalToken() else { throw DataSourceError.unauthorized }
        
        let request = MFRequest(url: "https://recipe-it.net/api/v1/recipe/detail/\(recipeID)")
            .get()
            .validate()
            .addHeaders([.authorization(bearerToken: localToken)])
        
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestDecodable(of: RecipeDTO.self, request)
        
        return response.value
    }
    
    public func generateRecipe(from source: String) async throws -> RecipeConversionDTO {
        guard let localToken = loginManager.loadLocalToken() else { throw DataSourceError.unauthorized }
        
        let request = MFRequest(url: "https://recipe-it.net/api/v1/recipe")
            .post()
            .validate()
            .addParameters(["source": source])
            .addHeaders([.authorization(bearerToken: localToken)])
        
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestDecodable(of: RecipeConversionDTO.self, request)
        
        return response.value
    }
    
    public func fetchRecipeState(recipeID: Int64) async throws -> RecipeStateDTO {
        guard let localToken = loginManager.loadLocalToken() else { throw DataSourceError.unauthorized }
        
        let request = MFRequest(url: "https://recipe-it.net/api/v1/recipe/state/\(recipeID)")
            .get()
            .validate()
            .addHeaders([.authorization(bearerToken: localToken)])
        
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestDecodable(of: RecipeStateDTO.self, request)
        
        return response.value
    }
    
    public func deleteRecipe(recipeID: Int64) async throws {
        guard let localToken = loginManager.loadLocalToken() else { throw DataSourceError.unauthorized }
        
        let request = MFRequest(url: "https://recipe-it.net/api/v1/recipe/\(recipeID)")
            .delete()
            .validate()
            .addHeaders([.authorization(bearerToken: localToken)])
        
        let _ = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .request(request)
    }
    
    public func filterCompletedRecipeIDs(from ids: [Int64]) async throws -> CompletedRecipeDTO {
        guard let localToken = loginManager.loadLocalToken() else { throw DataSourceError.unauthorized }
        
        let idString = ids.map { String($0) }.joined(separator: ",")
        
        let request = MFRequest(url: "https://recipe-it.net/api/v1/recipe/completed")
            .validate()
            .addQueries(["recipes": idString])
            .addHeaders([.authorization(bearerToken: localToken)])
        
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestDecodable(of: CompletedRecipeDTO.self, request)
        
        return response.value
    }
}
