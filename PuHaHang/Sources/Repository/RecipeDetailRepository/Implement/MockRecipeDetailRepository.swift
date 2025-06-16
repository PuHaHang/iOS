//
//  MockRecipeDetailRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

struct MockRecipeDetailRepository: RecipeDetailRepository {
    func fetchDetail(for recipeID: String) async throws -> RecipeDetail {
        return RecipeDetail(
            recipeID: "임시 ID",
            thumbnailURL: URL(filePath: "")!,
            title: "임시 레시피 타이틀",
            serving: 1,
            ingredients: [
                Ingredient(id: "1", name: "마요네즈", amount: "1스푼"),
                Ingredient(id: "1", name: "마요네즈", amount: "1스푼"),
                Ingredient(id: "1", name: "마요네즈", amount: "1스푼"),
                Ingredient(id: "1", name: "마요네즈", amount: "1스푼")
            ],
            steps: [
                Step(stepNumber: 1, instruction: "임시 레피시 스텝 입니다."),
                Step(stepNumber: 2, instruction: "임시 레피시 스텝 입니다."),
                Step(stepNumber: 3, instruction: "임시 레피시 스텝 입니다."),
                Step(stepNumber: 4, instruction: "임시 레피시 스텝 입니다."),
                Step(stepNumber: 5, instruction: "임시 레피시 스텝 입니다.")
            ]
        )
    }
}
