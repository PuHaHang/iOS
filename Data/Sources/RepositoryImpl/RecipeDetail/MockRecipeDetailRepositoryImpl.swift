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
    
    public func fetchDetail(for recipeID: Int64) async throws -> RecipeDetailVO {
        return RecipeDetailVO(
            recipeID: 0,
            title: "간단한 계란 샐러드",
            thumbnailURL: URL(string: "https://images.unsplash.com/photo-1482049016688-2d3e1b311543?q=80&w=2810&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!,
            serving: 2,
            reference: ReferenceVO.youtube(URL(string: "https://youtu.be/engr8PvZ98Q?si=UywXhbCmQkG4GvDR")!),
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
            stages: [
                StageVO(
                    step: 1,
                    timeline: .init(startTime: 0.0, endTime: 5.0),
                    instruction: "냄비에 계란과 물을 넣고 센 불에서 끓이세요. 물이 끓기 시작하면 중불로 줄여 10분 정도 더 삶으세요. 삶은 후 찬물에 담가 충분히 식혀주세요."
                ),
                StageVO(
                    step: 2,
                    timeline: .init(startTime: 5.0, endTime: 10.0),
                    instruction: "삶은 계란의 껍질을 벗기고 잘게 으깨세요. 양파, 피클, 샐러리 등은 잘게 다지세요."
                ),
                StageVO(
                    step: 3,
                    timeline: .init(startTime: 10.0, endTime: 15.0),
                    instruction: "볼에 마요네즈 2~3큰술, 머스터드 1작은술, 소금과 후추를 약간 넣고 잘 섞으세요. 기호에 따라 레몬즙이나 설탕을 조금 넣어도 좋습니다."
                ),
                StageVO(
                    step: 4,
                    timeline: .init(startTime: 15.0, endTime: 20.0),
                    instruction: "섞어둔 소스에 으깬 계란과 다진 양파, 피클, 샐러리를 넣고 골고루 섞어주세요. 재료가 잘 섞이면 맛을 보고 소금, 후추로 간을 맞추세요."
                ),
                StageVO(
                    step: 5,
                    timeline: .init(startTime: 20.0, endTime: 24.0),
                    instruction: "완성된 계란샐러드는 샌드위치 속으로 사용하거나 크래커 위에 올려 먹으면 좋아요. 냉장고에 1시간 정도 두면 맛이 더 잘 어우러집니다."
                )
            ]
        )
    }
    
    public func delete(for recipeID: Int64) async throws {
    }
}
