//
//  LocalError.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation

struct LocalError: Error {
    private let message: String
    
    var localizedDescription: String {
        message
    }
    
    init(message: String) {
        self.message = message
    }
}
