//
//  LogEventType.swift
//  Logger
//
//  Created by 디해 on 7/31/25.
//

import Foundation

public enum LogEventType {
    case screen(String)
    case buttonClick(String, String)
    case voiceRecognition(String)
}
