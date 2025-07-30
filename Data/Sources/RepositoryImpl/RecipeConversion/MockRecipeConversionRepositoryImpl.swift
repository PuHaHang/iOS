//
//  MockRecipeConversionRepositoryImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Domain

public struct MockRecipeConversionRepositoryImpl: RecipeConversionRepository {
    public init() { }
    
    public func convert(from input: String) async throws -> Int64 {
        return 0
    }
    }
}
