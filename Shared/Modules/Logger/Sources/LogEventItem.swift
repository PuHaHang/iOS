//
//  LogEventItem.swift
//  Logger
//
//  Created by 디해 on 7/31/25.
//

import Foundation

public struct LogEventItem {
    let type: LogEventType
    let message: String?
    let properties: [String: Any]?
}
