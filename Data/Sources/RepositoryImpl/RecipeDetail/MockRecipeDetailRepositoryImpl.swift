//
//  MockRecipeDetailRepositoryImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity
import Domain

public struct MockRecipeDetailRepositoryImpl: RecipeDetailRepository {
    public init() { }
    
    public func fetchDetail(for recipeID: UUID) async throws -> RecipeDetailVO {
        return RecipeDetailVO(
            recipeID: UUID(),
            thumbnailURL: URL(filePath: "")!,
            title: "임시 레시피 타이틀",
            serving: 1,
            reference: ReferenceVO.youtube(URL(string: "https://youtu.be/engr8PvZ98Q?si=UywXhbCmQkG4GvDR")!),
            ingredients: [
                IngredientVO(
                    id: UUID(),
                    name: "마요네즈",
                    amount: "1스푼"
                ),
                IngredientVO(
                    id: UUID(),
                    name: "마요네즈",
                    amount: "1스푼"
                ),
                IngredientVO(
                    id: UUID(),
                    name: "마요네즈",
                    amount: "1스푼"
                ),
                IngredientVO(
                    id: UUID(),
                    name: "마요네즈",
                    amount: "1스푼"
                )
            ],
            stages: [
                StageVO(
                    step: 1,
                    timeline: .init(startTime: 0.0, endTime: 5.0),
                    instruction: "임시 레피시 스텝 입니다."
                ),
                StageVO(
                    step: 2,
                    timeline: .init(startTime: 5.0, endTime: 10.0),
                    instruction: "임시 레피시 스텝 입니다."
                ),
                StageVO(
                    step: 3,
                    timeline: .init(startTime: 10.0, endTime: 15.0),
                    instruction: "임시 레피시 스텝 입니다."
                ),
                StageVO(
                    step: 4,
                    timeline: .init(startTime: 15.0, endTime: 20.0),
                    instruction: "임시 레피시 스텝 입니다."
                ),
                StageVO(
                    step: 5,
                    timeline: .init(startTime: 20.0, endTime: 24.0),
                    instruction: "임시 레피시 스텝 입니다."
                )
            ]
        )
    }
}
