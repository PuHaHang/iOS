//
//  ServerDecoder.swift
//  Data
//
//  Created by 디해 on 7/24/25.
//

import Foundation
import Minifire

final class ServerDecoder: MFErrorDecoder {
    static let shared = ServerDecoder()
    
    private init() {}
    
    typealias MFCustomError = ServerError
    
    func decodeError(from data: Data, response: HTTPURLResponse) throws -> ServerError {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(ServerError.self, from: data)
    }
}
