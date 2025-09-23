//
//  LoggerKey.swift
//  Logger
//
//  Created by 디해 on 7/31/25.
//

import Dependencies
import Foundation

public enum LoggerKey: TestDependencyKey {
    public static let testValue: Logger = EmptyLogger()
}

public extension DependencyValues {
    var logger: Logger {
        get { self[LoggerKey.self] }
        set { self[LoggerKey.self] = newValue }
    }
}
