//
//  UnimplementedError.swift
//  Domain
//
//  Created by 디해 on 7/2/25.
//

import Foundation

@inline(__always)
public func unimplementedFailure<T>(
    function: String = #function,
    file: String = #fileID,
    line: Int = #line
) -> T {
    fatalError("Domain Error: \(function) was called in an unimplemented use case at \(file):\(line)")
}

@inline(__always)
public func unimplementedFailure(
    function: String = #function,
    file: String = #fileID,
    line: Int = #line
) -> Never {
    fatalError("Domain Error: \(function) was called in an unimplemented use case at \(file):\(line)")
}
