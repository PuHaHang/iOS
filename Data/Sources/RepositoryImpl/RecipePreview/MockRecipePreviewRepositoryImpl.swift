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
    
    public func fetchPreview(for recipeID: Int64) async throws -> RecipePreviewVO {
        return RecipePreviewVO(
            recipeID: recipeID,
            thumbnailURL: URL(string: "https://images.unsplash.com/photo-1600891964599-f61ba0e24092")!,
            title: "임시 레시피 타이틀",
            servings: 1,
            ingredients: [
                IngredientVO(
                    id: 0,
                    name: "마요네즈",
                    amount: "1"
                ),
                IngredientVO(
                    id: 1,
                    name: "마요네즈",
                    amount: "1"
                ),
                IngredientVO(
                    id: 2,
                    name: "마요네즈",
                    amount: "1"
                ),
                IngredientVO(
                    id: 3,
                    name: "마요네즈",
                    amount: "1"
                )
            ],
            state: "COMPLETED"
        )
    }
    
    public func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreviewVO] {
        return [
            RecipePreviewVO(
                recipeID: 1,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1600891964599-f61ba0e24092")!,
                title: "맛있는 붕어빵",
                servings: 1,
                ingredients: [
                    IngredientVO(
                        id: 0,
                        name: "팥",
                        amount: "1스푼"
                    ),
                    IngredientVO(
                        id: 1,
                        name: "밀가루",
                        amount: "200g"
                    ),
                    IngredientVO(
                        id: 2,
                        name: "소금",
                        amount: "약간"
                    ),
                    IngredientVO(
                        id: 3,
                        name: "달걀",
                        amount: "1개"
                    )
                ],
                state: "PENDING"),
            RecipePreviewVO(
                recipeID: 2,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1600891964599-f61ba0e24092")!,
                title: "포동포동 만두",
                servings: 1,
                ingredients: [
                    IngredientVO(
                        id: 0,
                        name: "팥",
                        amount: "1스푼"
                    ),
                    IngredientVO(
                        id: 1,
                        name: "밀가루",
                        amount: "200g"
                    ),
                    IngredientVO(
                        id: 2,
                        name: "소금",
                        amount: "약간"
                    ),
                    IngredientVO(
                        id: 3,
                        name: "달걀",
                        amount: "1개"
                    )
                ],
                state: "PENDING"),
            RecipePreviewVO(
                recipeID: 3,
                thumbnailURL: URL(string: "https://images.unsplash.com/photo-1600891964599-f61ba0e24092")!,
                title: "보글보글 된장찌개",
                servings: 1,
                ingredients: [
                    IngredientVO(
                        id: 0,
                        name: "팥",
                        amount: "1스푼"
                    ),
                    IngredientVO(
                        id: 1,
                        name: "밀가루",
                        amount: "200g"
                    ),
                    IngredientVO(
                        id: 2,
                        name: "소금",
                        amount: "약간"
                    ),
                    IngredientVO(
                        id: 3,
                        name: "달걀",
                        amount: "1개"
                    )
                ],
                state: "PENDING"),
            ]
    }
}
