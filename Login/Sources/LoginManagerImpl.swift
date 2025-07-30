//
//  LoginManagerImpl.swift
//  Login
//
//  Created by 디해 on 7/27/25.
//

import Dependencies
import Foundation
import Shared
import Minifire

public struct LoginManagerImpl: LoginManager {
    let fcmTokenService = FCMTokenService()
    let localTokenService = LocalTokenService()
    
    public init() {}
}

extension LoginManagerImpl {
    public func createGuestToken(region: String) async throws -> String {
        let request = MFRequest(url: "http://121.157.24.40/api/v1/user/guest")
            .post()
            .validate()
            .addParameters(["region": region])
        
        let response = try await MF
            .setErrorDecoder(LoginDecoder.shared)
            .request(request)
        
        guard let token = response.httpResponse?.value(forHTTPHeaderField: "X-Guest-Token") else {
            throw LoginError.invalidResponse
        }
        return token
    }
}

// MARK: - Local Token
extension LoginManagerImpl {
    public func loadLocalToken() -> String? {
        let token = localTokenService.loadToken()
        return token
    }
    
    public func saveLocalToken(_ token: String) {
        localTokenService.save(token: token)
    }
    
    public func deleteLocalToken() {
        localTokenService.deleteToken()
    }
}

// MARK: - FCM Token
extension LoginManagerImpl {
    public func loadFCMToken() async throws -> String {
        try await fcmTokenService.loadToken()
    }
    
    public func update(fcmToken: String, for userToken: String) async throws {
        try await fcmTokenService.update(token: fcmToken, for: userToken)
    }
}

extension HTTPURLResponse {
    func value(forHTTPHeaderField field: String) -> String? {
        for (key, value) in allHeaderFields {
            if let keyString = key as? String,
               keyString.caseInsensitiveCompare(field) == .orderedSame {
                return value as? String
            }
        }
        return nil
    }
}
