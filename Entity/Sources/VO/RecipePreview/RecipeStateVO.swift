//
//  RecipeStateVO.swift
//  Entity
//
//  Created by 디해 on 7/12/25.
//

import Foundation

public enum RecipeStateVO: String {
    case pending = "PENDING"
    case pended = "PENDED"
    case verifying = "VERIFYING"
    case verified = "VERIFIED"
    case transforming = "TRANSFORMING"
    case transformed = "TRANSFORMED"
    case processing = "PROCESSING"
    case evaluating = "EVALUATING"
    case completed = "COMPLETED"
    case failed = "FAILED"
    case cancelled = "CANCELLED"
    case unknown

    public init(rawValue: String) {
        switch rawValue {
        case RecipeStateVO.pending.rawValue:
            self = .pending
        case RecipeStateVO.pended.rawValue:
            self = .pended
        case RecipeStateVO.verifying.rawValue:
            self = .verifying
        case RecipeStateVO.verified.rawValue:
            self = .verified
        case RecipeStateVO.transforming.rawValue:
            self = .transforming
        case RecipeStateVO.transformed.rawValue:
            self = .transformed
        case RecipeStateVO.processing.rawValue:
            self = .processing
        case RecipeStateVO.evaluating.rawValue:
            self = .evaluating
        case RecipeStateVO.completed.rawValue:
            self = .completed
        case RecipeStateVO.failed.rawValue:
            self = .failed
        case RecipeStateVO.cancelled.rawValue:
            self = .cancelled
        default:
            self = .unknown
        }
    }
}
