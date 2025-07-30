//
//  FetchConvertedPreviewUseCase.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import Foundation

public protocol FetchConvertedRecipeIDUseCase {
    func execute(_ source: String) async -> Result<Int64, Error>
}
