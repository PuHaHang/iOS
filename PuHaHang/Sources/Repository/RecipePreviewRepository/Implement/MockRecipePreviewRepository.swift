//
//  MockRecipePreviewRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

struct MockRecipePreviewRepository: RecipePreviewRepository {
    func fetchPreview(for recipeID: String) async throws -> RecipePreview {
        return RecipePreview(
            recipeID: "임시 ID",
            thumbnailURL: URL(filePath: "")!,
            title: "임시 레시피 타이틀",
            serving: 1,
            ingredients: [
                Ingredient(id: "1", name: "마요네즈", amount: "1스푼"),
                Ingredient(id: "1", name: "마요네즈", amount: "1스푼"),
                Ingredient(id: "1", name: "마요네즈", amount: "1스푼"),
                Ingredient(id: "1", name: "마요네즈", amount: "1스푼")
            ]
        )
    }
    
    func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreview] {
        let preview = RecipePreview(
            recipeID: "임시 ID",
            thumbnailURL: URL(filePath: "")!,
            title: "맛있는 붕어빵",
            serving: 1,
            ingredients: [
                Ingredient(id: "1", name: "팥", amount: "1스푼"),
                Ingredient(id: "1", name: "밀가루", amount: "200g"),
                Ingredient(id: "1", name: "소금", amount: "약간"),
                Ingredient(id: "1", name: "달걀", amount: "1개")
            ]
        )
        
        return Array(repeating: preview, count: pageSize)
    }
}
