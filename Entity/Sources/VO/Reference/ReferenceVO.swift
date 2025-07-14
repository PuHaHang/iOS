//
//  ReferenceVO.swift
//  PuHaHang
//
//  Created by 디해 on 6/21/25.
//

import Foundation

public enum ReferenceVO {
    case youtube(URL)
    case shorts(URL)
    case text(String)
    case unknown

    public static func from(type rawType: String, value: String) -> ReferenceVO {
        if let type = ReferenceTypeVO(rawValue: rawType) {
            switch type {
            case .youtube:
                guard let url = URL(string: value) else { return .unknown }
                return .youtube(url)
            case .shorts:
                guard let url = URL(string: value) else { return .unknown }
                return .shorts(url)
            case .text:
                return .text(value)
            }
        } else {
            return .unknown
        }
    }
}

extension ReferenceVO {
    enum ReferenceTypeVO: String {
        case youtube
        case shorts
        case text
    }
}
