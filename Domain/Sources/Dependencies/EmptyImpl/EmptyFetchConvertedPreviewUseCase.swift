//
//  EmptyFetchConvertedPreviewUseCase.swift
//  Domain
//
//  Created by 디해 on 7/2/25.
//

import Entity
import Foundation

struct EmptyFetchConvertedPreviewUseCase: FetchConvertedPreviewUseCase {
    func execute(_ source: String) async -> Result<RecipePreviewVO, any Error> {
        unimplementedFailure()
    }
}
