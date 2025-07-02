//
//  MockRecipeDetailRepositoryImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity
import Domain

struct MockRecipeDetailRepositoryImpl: RecipeDetailRepository {
    func fetchDetail(for recipeID: UUID) async throws -> RecipeDetailVO {
        return RecipeDetailVO(
            recipeID: UUID(),
            thumbnailURL: URL(filePath: "")!,
            title: "임시 레시피 타이틀",
            serving: 1,
            reference: ReferenceVO.text(""),
            ingredients: [
                IngredientVO(id: UUID(), name: "마요네즈", amount: "1스푼"),
                IngredientVO(id: UUID(), name: "마요네즈", amount: "1스푼"),
                IngredientVO(id: UUID(), name: "마요네즈", amount: "1스푼"),
                IngredientVO(id: UUID(), name: "마요네즈", amount: "1스푼")
            ],
            stages: [
                StageVO(step: 1, timeline: 0.0, instruction: "임시 레피시 스텝 입니다."),
                StageVO(step: 2, timeline: 0.0, instruction: "임시 레피시 스텝 입니다."),
                StageVO(step: 3, timeline: 0.0, instruction: "임시 레피시 스텝 입니다."),
                StageVO(step: 4, timeline: 0.0, instruction: "임시 레피시 스텝 입니다."),
                StageVO(step: 5, timeline: 0.0, instruction: "임시 레피시 스텝 입니다.")
            ]
        )
    }
}
