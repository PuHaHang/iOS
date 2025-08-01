//
//  Logger.swift
//  Logger
//
//  Created by 디해 on 7/31/25.
//

import Foundation

public protocol Logger {
    func track(_ event: LogEvent)
}
