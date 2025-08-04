//
//  RecipeListVO.swift
//  Entity
//
//  Created by 디해 on 8/3/25.
//

import Foundation

public struct RecipeListVO {
    public let previews: [RecipePreviewVO]
    public let hasNext: Bool
    public let cursorId: Int?
    
    public init(
        previews: [RecipePreviewVO],
        hasNext: Bool,
        cursorId: Int?
    ) {
        self.previews = previews
        self.hasNext = hasNext
        self.cursorId = cursorId
    }
}
