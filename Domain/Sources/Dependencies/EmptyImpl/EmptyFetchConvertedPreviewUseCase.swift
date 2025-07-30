//
//  EmptyFetchConvertedPreviewUseCase.swift
//  Domain
//
//  Created by 디해 on 7/2/25.
//

import Foundation

struct EmptyFetchConvertedPreviewUseCase: FetchConvertedRecipeIDUseCase {
    func execute(_ source: String) async -> Result<Int64, any Error> {
        unimplementedFailure()
    }
}
