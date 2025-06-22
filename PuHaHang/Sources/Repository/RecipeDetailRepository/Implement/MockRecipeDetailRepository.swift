//
//  MockRecipeDetailRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

struct MockRecipeDetailRepository: RecipeDetailRepository {
    func fetchDetail(for recipeID: UUID) async throws -> RecipeDetail {
        return RecipeDetail(
            recipeID: UUID(),
            thumbnailURL: URL(filePath: "")!,
            title: "임시 레시피 타이틀",
            serving: 1,
            reference: Reference.text(""),
            ingredients: [
                Ingredient(id: UUID(), name: "마요네즈", amount: "1스푼"),
                Ingredient(id: UUID(), name: "마요네즈", amount: "1스푼"),
                Ingredient(id: UUID(), name: "마요네즈", amount: "1스푼"),
                Ingredient(id: UUID(), name: "마요네즈", amount: "1스푼")
            ],
            stages: [
                Stage(step: 1, timeline: 0.0, instruction: "임시 레피시 스텝 입니다."),
                Stage(step: 2, timeline: 0.0, instruction: "임시 레피시 스텝 입니다."),
                Stage(step: 3, timeline: 0.0, instruction: "임시 레피시 스텝 입니다."),
                Stage(step: 4, timeline: 0.0, instruction: "임시 레피시 스텝 입니다."),
                Stage(step: 5, timeline: 0.0, instruction: "임시 레피시 스텝 입니다.")
            ]
        )
    }
}
