//
//  LoginManagerDependency.swift
//  Login
//
//  Created by 디해 on 7/27/25.
//

import Dependencies
import Foundation

public enum LoginManagerKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: LoginManager = EmptyLoginManager()
    #endif
}

public extension DependencyValues {
    var loginManager: LoginManager {
        get { self[LoginManagerKey.self] }
        set { self[LoginManagerKey.self] = newValue }
    }
}
