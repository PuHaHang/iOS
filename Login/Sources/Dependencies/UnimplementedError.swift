//
//  UnimplementedError.swift
//  Login
//
//  Created by 디해 on 7/27/25.
//

import Foundation

@inline(__always)
public func throwUnimplemented(
    function: String = #function,
    file: String = #fileID,
    line: Int = #line
) -> Never {
    fatalError("Login Error: \(function) was called in an unimplemented at \(file):\(line)")
}
