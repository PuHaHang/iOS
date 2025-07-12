//
//  MockRecipePreviewRepositoryImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity
import Domain

public struct MockRecipePreviewRepositoryImpl: RecipePreviewRepository {
    public init() { }
    
    public func fetchPreview(for recipeID: UUID) async throws -> RecipePreviewVO {
        return RecipePreviewVO(
            recipeID: UUID(),
            thumbnailURL: URL(filePath: "")!,
            title: "임시 레시피 타이틀",
            serving: 1,
            ingredients: [
                IngredientVO(id: UUID(), name: "마요네즈", amount: "1스푼"),
                IngredientVO(id: UUID(), name: "마요네즈", amount: "1스푼"),
                IngredientVO(id: UUID(), name: "마요네즈", amount: "1스푼"),
                IngredientVO(id: UUID(), name: "마요네즈", amount: "1스푼")
            ],
            state: 1
        )
    }
    
    public func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreviewVO] {
        let preview = RecipePreviewVO(
            recipeID: UUID(),
            thumbnailURL: URL(filePath: "")!,
            title: "맛있는 붕어빵",
            serving: 1,
            ingredients: [
                IngredientVO(id: UUID(), name: "팥", amount: "1스푼"),
                IngredientVO(id: UUID(), name: "밀가루", amount: "200g"),
                IngredientVO(id: UUID(), name: "소금", amount: "약간"),
                IngredientVO(id: UUID(), name: "달걀", amount: "1개")
            ],
            state: 0
        )
        
        return Array(repeating: preview, count: pageSize)
    }
}
