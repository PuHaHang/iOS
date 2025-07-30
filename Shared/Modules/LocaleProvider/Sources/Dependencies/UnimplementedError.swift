//
//  UnimplementedError.swift
//  LocaleProvider
//
//  Created by 디해 on 7/24/25.
//

import Foundation

@inline(__always)
public func throwUnimplemented(
    function: String = #function,
    file: String = #fileID,
    line: Int = #line
) -> Never {
    fatalError("LocaleProvider Error: \(function) was called in an unimplemented at \(file):\(line)")
}
