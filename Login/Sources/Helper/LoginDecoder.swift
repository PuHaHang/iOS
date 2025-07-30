//
//  LoginDecoder.swift
//  Login
//
//  Created by 디해 on 7/27/25.
//

import Foundation
import Minifire

final class LoginDecoder: MFErrorDecoder {
    static let shared = LoginDecoder()
    
    private init() {}
    
    typealias MFCustomError = LoginErrorType
    
    func decodeError(from data: Data, response: HTTPURLResponse) throws -> LoginErrorType {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(LoginErrorType.self, from: data)
    }
}
