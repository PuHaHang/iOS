//
//  LoggerKey.swift
//  Logger
//
//  Created by 디해 on 7/31/25.
//

import Dependencies
import Foundation

public enum LoggerKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: Logger = EmptyLogger()
    #endif
}

public extension DependencyValues {
    var logger: Logger {
        get { self[LoggerKey.self] }
        set { self[LoggerKey.self] = newValue }
    }
}
