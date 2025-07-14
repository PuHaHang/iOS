//
//  ReferenceViewData.swift
//  Presentation
//
//  Created by 디해 on 7/3/25.
//

import Foundation

enum ReferenceViewData {
    case youtube(URL)
    case shorts(URL)
    case text(String)
    case unknown
    
    var externalLink: URL? {
        switch self {
        case .youtube(let url):
            url
        case .shorts(let url):
            url
        case .text:
            nil
        case .unknown:
            nil
        }
    }
    
    var hasExternalLink: Bool {
        self.externalLink != nil
    }
}
