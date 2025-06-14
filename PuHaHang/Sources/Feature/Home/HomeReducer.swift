//
//  HomeReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation
import UIKit

@Reducer
struct HomeReducer {
    @ObservableState
    struct State {
        let titleIconName: String = "title_icon"
        var recipes: IdentifiedArrayOf<RecipeListItemReducer.State> = [
            .init(
                id: UUID(),
                item: RecipeListItem(
                    recipeID: "1번 레시피",
                    thumbnail: UIImage(),
                    title: "간단한 계란 샐러드",
                    serving: "2인분",
                    ingredients: "계란 4알, 소금, 후추, 마요네즈, 양파, 당근, 샐러리"
                )
            ),
            .init(
                id: UUID(),
                item: RecipeListItem(
                    recipeID: "2번 레시피",
                    thumbnail: UIImage(),
                    title: "초간단 햄버거",
                    serving: "4인분",
                    ingredients: "햄버거 번, 패티, 슬라이스 치즈, 양상추, 토마토, 양파, 피클, 케첩, 마요네즈, 머스타드"
                )
            ),
            .init(
                id: UUID(),
                item: RecipeListItem(
                    recipeID: "3번 레시피",
                    thumbnail: UIImage(),
                    title: "존맛탱 부대찌개",
                    serving: "3인분",
                    ingredients: "스팸, 비엔나 소세지, 두부, 김치, 양파, 마늘, 라면사리, 슬라이스 치즈, 육수, 고추장"
                )
            ),
            .init(
                id: UUID(),
                item: RecipeListItem(
                    recipeID: "4번 레시피",
                    thumbnail: UIImage(),
                    title: "간단한 계란 샐러드",
                    serving: "2인분",
                    ingredients: "계란 4알, 소금, 후추, 마요네즈, 양파, 당근, 샐러리"
                )
            ),
            .init(
                id: UUID(),
                item: RecipeListItem(
                    recipeID: "5번 레시피",
                    thumbnail: UIImage(),
                    title: "초간단 햄버거",
                    serving: "4인분",
                    ingredients: "햄버거 번, 패티, 슬라이스 치즈, 양상추, 토마토, 양파, 피클, 케첩, 마요네즈, 머스타드"
                )
            ),
            .init(
                id: UUID(),
                item: RecipeListItem(
                    recipeID: "6번 레시피",
                    thumbnail: UIImage(),
                    title: "존맛탱 부대찌개",
                    serving: "3인분",
                    ingredients: "스팸, 비엔나 소세지, 두부, 김치, 양파, 마늘, 라면사리, 슬라이스 치즈, 육수, 고추장"
                )
            )
        ]
    }
    
    enum Action {
        case recipes(IdentifiedActionOf<RecipeListItemReducer>)
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .recipes(.element(id: _, action: .didTapItem(let item))):
                return .send(.delegate(.showRecipeDetail(item)))
                
            case .delegate:
                return .none
            }
        }
        .forEach(\.recipes, action: \.recipes) {
            RecipeListItemReducer()
        }
    }
}

extension HomeReducer.Action {
    enum Delegate: Equatable {
        case showRecipeDetail(RecipeListItem)
    }
}
