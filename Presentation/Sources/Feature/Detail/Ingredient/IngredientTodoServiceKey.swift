//
//  IngredientTodoServiceKey.swift
//  Presentation
//
//  Created by 디해 on 6/8/25.
//

import Dependencies
import Foundation

enum IngredientTodoServiceKey: DependencyKey {
    static let liveValue = IngredientTodoService()
}

extension DependencyValues {
    var ingredientTodoService: IngredientTodoService {
        get { self[IngredientTodoServiceKey.self] }
        set { self[IngredientTodoServiceKey.self] = newValue }
    }
} 