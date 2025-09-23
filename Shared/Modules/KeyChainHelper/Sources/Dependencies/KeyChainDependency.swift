//
//  KeyChainDependency.swift
//  KeyChainHelper
//
//  Created by 디해 on 7/26/25.
//

import Dependencies
import Foundation

public enum KeyChainHelperKey: TestDependencyKey {
    public static let testValue: KeyChainHelper = EmptyKeyChainHelper()
}

public extension DependencyValues {
    var keyChainHelper: KeyChainHelper {
        get { self[KeyChainHelperKey.self] }
        set { self[KeyChainHelperKey.self] = newValue }
    }
}
