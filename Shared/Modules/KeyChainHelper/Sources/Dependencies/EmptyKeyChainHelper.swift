//
//  EmptyKeyChainHelper.swift
//  KeyChainHelper
//
//  Created by 디해 on 7/26/25.
//

import Foundation

public struct EmptyKeyChainHelper: KeyChainHelper {
    public func save(value: String, forKey key: String) -> Bool {
        throwUnimplemented()
    }
    
    public func get(forKey key: String) -> String? {
        throwUnimplemented()
    }
    
    public func delete(forKey key: String) -> Bool {
        throwUnimplemented()
    }
}
