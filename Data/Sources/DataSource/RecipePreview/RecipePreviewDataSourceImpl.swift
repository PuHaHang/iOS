//
//  RecipePreviewDataSourceImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/21/25.
//

import Dependencies
import Foundation
import Minifire
import Login

public struct RecipePreviewDataSourceImpl: RecipePreviewDataSource {
    @Dependency(\.loginManager) var loginManager
    
    public init() { }
    
    public func fetchPreview(recipeID: Int64) async throws -> RecipePreviewDTO {
        guard let localToken = loginManager.loadLocalToken() else { throw DataSourceError.unauthorized }
        
        let request = MFRequest(url: "http://121.157.24.40/api/v1/recipe/list/\(recipeID)")
            .validate()
            .addHeaders([.authorization(bearerToken: localToken)])
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestDecodable(of: RecipePreviewDTO.self, request)
        
        return response.value
    }
    
    public func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreviewDTO] {
        guard let localToken = loginManager.loadLocalToken() else { throw DataSourceError.unauthorized }
        
        let request = MFRequest(url: "http://121.157.24.40/api/v1/recipe/list")
            .validate()
            .addQueries(["page": page, "size": pageSize])
            .addHeaders([.authorization(bearerToken: localToken)])
        
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestDecodable(of: [RecipePreviewDTO].self, request)
    
        return response.value
    }
}
