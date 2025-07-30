//
//  LoginErrorType.swift
//  Login
//
//  Created by 디해 on 7/27/25.
//

import Foundation

struct LoginErrorType: Error, Decodable {
    let errorCode: String
    let message: String
    let detail: String?
}
