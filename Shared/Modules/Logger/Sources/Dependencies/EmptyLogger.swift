//
//  EmptyLogger.swift
//  Logger
//
//  Created by 디해 on 7/31/25.
//

import Foundation

public struct EmptyLogger: Logger {
    public func track(_ event: LogEvent) {
        throwUnimplemented()
    }
}
