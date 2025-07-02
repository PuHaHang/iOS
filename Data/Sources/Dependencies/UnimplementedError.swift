//
//  UnimplementedError.swift
//  Data
//
//  Created by 디해 on 7/2/25.
//

import Foundation

@inline(__always)
public func throwUnimplemented(
    function: String = #function,
    file: String = #fileID,
    line: Int = #line
) -> Never {
    fatalError("Data Error: \(function) was called in an unimplemented repository at \(file):\(line)")
}
