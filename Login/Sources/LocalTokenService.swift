//
//  LocalTokenService.swift
//  Login
//
//  Created by 디해 on 7/27/25.
//

import Dependencies
import Foundation
import Shared

struct LocalTokenService {
    @Dependency(\.keyChainHelper) var keyChainHelper
    
    private let key: String = "accessToken"
    
    public init() {}
    
    func loadToken() -> String? {
        keyChainHelper.get(forKey: key)
    }
    
    func save(token: String) {
        keyChainHelper.delete(forKey: key)
        keyChainHelper.save(value: token, forKey: key)
    }
    
    func deleteToken() {
        keyChainHelper.delete(forKey: key)
    }
}
