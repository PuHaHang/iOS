//
//  ServerError.swift
//  Data
//
//  Created by 디해 on 7/24/25.
//

import Foundation

struct ServerError: Error, Decodable {
    let errorCode: String
    let message: String?
    let detail: String?
}
