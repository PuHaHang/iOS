//
//  Reference.swift
//  PuHaHang
//
//  Created by 디해 on 6/21/25.
//

import Foundation

enum Reference {
    case youtube(URL)
    case text(String)
    case unknown

    static func from(type rawType: String, value: String) -> Reference {
        if let type = ReferenceType(rawValue: rawType) {
            switch type {
            case .youtube:
                guard let url = URL(string: value) else { return .unknown }
                return .youtube(url)
            case .text:
                return .text(value)
            }
        } else {
            return .unknown
        }
    }
}

extension Reference {
    enum ReferenceType: String {
        case youtube
        case text
    }
}
