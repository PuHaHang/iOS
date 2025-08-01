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
    case text
    case unknown
    
    public static func from(type rawType: String, urlString: String?, metadataString: String?) -> ReferenceVO {
        switch rawType {
        case "YOUTUBE":
            guard let urlString,
                  let url = URL(string: urlString) else { return .unknown }
            
            if let metadataString = metadataString,
               !metadataString.isEmpty,
               metadataString != "{}",
               let data = metadataString.data(using: .utf8),
               let metadata = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let isShort = metadata["is_shorts"] as? Bool {
                return isShort ? .shorts(url) : .youtube(url)
            } else {
                return .youtube(url)
            }
            
        case "TEXT":
            return .text
            
        default:
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
