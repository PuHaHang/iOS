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
    struct State: Equatable {
        let titleIconName: String = "title_icon"
        var items: IdentifiedArrayOf<RecipeListItemReducer.State> = [
            .init(
                id: UUID(),
                thumbnail: UIImage(),
                title: "간단한 계란 샐러드",
                serving: "2인분",
                ingredients: "계란 4알, 소금, 후추, 마요네즈, 양파, 당근, 샐러리"
            ),
            .init(
                id: UUID(),
                thumbnail: UIImage(),
                title: "초간단 햄버거",
                serving: "4인분",
                ingredients: "햄버거 번, 패티, 슬라이스 치즈, 양상추, 토마토, 양파, 피클, 케첩, 마요네즈, 머스타드"
            ),
            .init(
                id: UUID(),
                thumbnail: UIImage(),
                title: "존맛탱 부대찌개",
                serving: "3인분",
                ingredients: "스팸, 비엔나 소세지, 두부, 김치, 양파, 마늘, 라면사리, 슬라이스 치즈, 육수, 고추장"
            ),
            .init(
                id: UUID(),
                thumbnail: UIImage(),
                title: "간단한 계란 샐러드",
                serving: "2인분",
                ingredients: "계란 4알, 소금, 후추, 마요네즈, 양파, 당근, 샐러리"
            ),
            .init(
                id: UUID(),
                thumbnail: UIImage(),
                title: "초간단 햄버거",
                serving: "4인분",
                ingredients: "햄버거 번, 패티, 슬라이스 치즈, 양상추, 토마토, 양파, 피클, 케첩, 마요네즈, 머스타드"
            ),
            .init(
                id: UUID(),
                thumbnail: UIImage(),
                title: "존맛탱 부대찌개",
                serving: "3인분",
                ingredients: "스팸, 비엔나 소세지, 두부, 김치, 양파, 마늘, 라면사리, 슬라이스 치즈, 육수, 고추장"
            )
        ]
    }
    
    enum Action: Equatable {
        case items(IdentifiedActionOf<RecipeListItemReducer>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .items(.element(id: let id, action: .didTapItem)):
                print(">>> tapped item id: \(id)")
                return .none
            }
        }
        .forEach(\.items, action: \.items) {
            RecipeListItemReducer()
        }
    }
}
