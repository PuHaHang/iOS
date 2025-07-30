//
//  IngredientTodoService.swift
//  Presentation
//
//  Created by 디해 on 6/8/25.
//

import Foundation

actor IngredientTodoService {
    private let fileName = "ingredient_todos.json"
    private var todos: [String: [String: Bool]] = [:]
    private var isLoaded = false
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    private func loadFromFile() async {
        guard !isLoaded, let fileURL else { return }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let loadedTodos = try JSONDecoder().decode([String: [String: Bool]].self, from: data)
            todos = loadedTodos
        } catch {
            todos = [:]
        }
        isLoaded = true
    }
    
    private func saveToFile() async {
        guard let fileURL else { return }
        
        do {
            let data = try JSONEncoder().encode(todos)
            try data.write(to: fileURL)
        } catch {
            print("투두 데이터 저장 실패: \(error)")
        }
    }
    
    func getTodos(for recipeID: Int64) async -> [String: Bool] {
        await loadFromFile()
        return todos[String(recipeID)] ?? [:]
    }
    
    func setTodos(_ ingredientTodos: [String: Bool], for recipeID: Int64) async {
        await loadFromFile()
        todos[String(recipeID)] = ingredientTodos
        await saveToFile()
    }
    
    func toggleTodo(ingredientID: Int64, for recipeID: Int64) async {
        await loadFromFile()
        
        let recipeKey = String(recipeID)
        var recipeTodos = todos[recipeKey] ?? [:]
        recipeTodos[String(ingredientID)] = recipeTodos[String(ingredientID)] ?? false
        todos[recipeKey] = recipeTodos
        
        await saveToFile()
    }
    
    func setTodo(ingredientID: Int64, isCompleted: Bool, for recipeID: Int64) async {
        await loadFromFile()
        
        let recipeKey = String(recipeID)
        var recipeTodos = todos[recipeKey] ?? [:]
        recipeTodos[String(ingredientID)] = isCompleted
        todos[recipeKey] = recipeTodos
        
        await saveToFile()
    }
    
    func initializeRecipe(recipeID: Int64, ingredients: [Int64]) async {
        await loadFromFile()
        
        let recipeKey = String(recipeID)
        var recipeTodos = todos[recipeKey] ?? [:]
        
        for ingredient in ingredients {
            if recipeTodos[String(ingredient)] == nil {
                recipeTodos[String(ingredient)] = false
            }
        }
        
        todos[recipeKey] = recipeTodos
        await saveToFile()
    }
    
    func resetTodos(for recipeID: Int64) async {
        await loadFromFile()
        todos[String(recipeID)] = [:]
        await saveToFile()
    }
    
    func clearAllTodos() async {
        todos = [:]
        await saveToFile()
    }
} 
