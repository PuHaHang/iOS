//
//  UnimplementedError.swift
//  Audio
//
//  Created by 디해 on 7/13/25.
//

import Foundation

@inline(__always)
public func throwUnimplemented(
    function: String = #function,
    file: String = #fileID,
    line: Int = #line
) -> Never {
    fatalError("Audio Error: \(function) was called in an unimplemented at \(file):\(line)")
}
