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
    
    private let fileManager = FileManager.default
    private var cacheDirectory: URL {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let cacheDir = documentsDirectory.appendingPathComponent("RecipeCache")
        
        if !fileManager.fileExists(atPath: cacheDir.path) {
            try? fileManager.createDirectory(at: cacheDir, withIntermediateDirectories: true)
        }
        
        return cacheDir
    }
    
    public init() { }
    
    public func fetchPreview(recipeID: Int64) async throws -> RecipePreviewDTO {
        guard let localToken = loginManager.loadLocalToken() else { throw DataSourceError.unauthorized }
        
        let request = MFRequest(url: "https://recipe-it.net/api/v1/recipe/list/\(recipeID)")
            .validate()
            .addHeaders([.authorization(bearerToken: localToken)])
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestDecodable(of: RecipePreviewDTO.self, request)
        
        return response.value
    }
    
    public func fetchPreviews(cursorId: Int?, size: Int, fromCache: Bool = false) async throws -> RecipeListDTO {
        if fromCache && cursorId == nil {
            return try loadPreviewsFromCache(size: size)
        }
        
        guard let localToken = loginManager.loadLocalToken() else { throw DataSourceError.unauthorized }
        
        let request = MFRequest(url: "https://recipe-it.net/api/v1/recipe/list")
            .validate()
            .addQueries(["size": size])
            .addHeaders([.authorization(bearerToken: localToken)])
        
        if let cursorId {
            request.addQueries(["cursorId": cursorId])
        }
        
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestDecodable(of: RecipeListDTO.self, request)
        
        if cursorId == nil {
            try? savePreviewsToCache(response.value, size: size)
        }
        
        return response.value
    }
    
    private func savePreviewsToCache(_ data: RecipeListDTO, size: Int) throws {
        let fileURL = cacheDirectory.appendingPathComponent("previews_first_\(size).json")
        let jsonData = try JSONEncoder().encode(data)
        try jsonData.write(to: fileURL)
    }
    
    private func loadPreviewsFromCache(size: Int) throws -> RecipeListDTO {
        let fileURL = cacheDirectory.appendingPathComponent("previews_first_\(size).json")
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode(RecipeListDTO.self, from: data)
    }
    
    public func clearCache() throws {
        let contents = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
        for fileURL in contents {
            try fileManager.removeItem(at: fileURL)
        }
    }
}
