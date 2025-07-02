//
//  RecipeConversionRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

public protocol RecipeConversionRepository {
    func convert(from input: String) async throws -> UUID
}
