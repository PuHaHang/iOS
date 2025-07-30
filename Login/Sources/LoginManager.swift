//
//  LoginManager.swift
//  Login
//
//  Created by 디해 on 7/27/25.
//

import Foundation

public protocol LoginManager {
    func createGuestToken(region: String) async throws -> String
    func loadLocalToken() -> String?
    func saveLocalToken(_ token: String)
    func deleteLocalToken()
    func loadFCMToken() async throws -> String
    func update(fcmToken: String, for userToken: String) async throws
}
