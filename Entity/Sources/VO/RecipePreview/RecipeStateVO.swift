//
//  RecipeStateVO.swift
//  Entity
//
//  Created by 디해 on 7/12/25.
//

import Foundation

public enum RecipeStateVO: Int {
    case inProgress = 0
    case completed = 1
    case unknown

    public init(rawValue: Int) {
        switch rawValue {
        case RecipeStateVO.inProgress.rawValue:
            self = .inProgress
        case RecipeStateVO.completed.rawValue:
            self = .completed
        default:
            self = .unknown
        }
    }
}
