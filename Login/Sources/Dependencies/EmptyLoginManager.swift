//
//  EmptyLoginManager.swift
//  Login
//
//  Created by 디해 on 7/27/25.
//

import Foundation

public struct EmptyLoginManager: LoginManager {
    public func createGuestToken(region: String) async throws -> String {
        throwUnimplemented()
    }
    
    public func loadLocalToken() -> String? {
        throwUnimplemented()
    }
    
    public func saveLocalToken(_ token: String) {
        throwUnimplemented()
    }
    
    public func deleteLocalToken() {
        throwUnimplemented()
    }
    
    public func loadFCMToken() async throws -> String {
        throwUnimplemented()
    }
    
    public func update(fcmToken: String, for userToken: String) async throws {
        throwUnimplemented()
    }
}
