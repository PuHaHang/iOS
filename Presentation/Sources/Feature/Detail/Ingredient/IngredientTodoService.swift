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
    
    private func saveToFile() async throws {
        guard let fileURL else { return }
        
        let data = try JSONEncoder().encode(todos)
        try data.write(to: fileURL)
    }
    
    func getTodos(for recipeID: Int64) async -> [String: Bool] {
        await loadFromFile()
        return todos[String(recipeID)] ?? [:]
    }
    
    func setTodos(_ ingredientTodos: [String: Bool], for recipeID: Int64) async throws {
        await loadFromFile()
        todos[String(recipeID)] = ingredientTodos
        try await saveToFile()
    }
    
    func toggleTodo(ingredientID: Int64, for recipeID: Int64) async throws {
        await loadFromFile()
        
        let recipeKey = String(recipeID)
        var recipeTodos = todos[recipeKey] ?? [:]
        recipeTodos[String(ingredientID)] = recipeTodos[String(ingredientID)] ?? false
        todos[recipeKey] = recipeTodos
        
        try await saveToFile()
    }
    
    func setTodo(ingredientID: Int64, isCompleted: Bool, for recipeID: Int64) async throws {
        await loadFromFile()
        
        let recipeKey = String(recipeID)
        var recipeTodos = todos[recipeKey] ?? [:]
        recipeTodos[String(ingredientID)] = isCompleted
        todos[recipeKey] = recipeTodos
        
        try await saveToFile()
    }
    
    func initializeRecipe(recipeID: Int64, ingredients: [Int64]) async throws {
        await loadFromFile()
        
        let recipeKey = String(recipeID)
        var recipeTodos = todos[recipeKey] ?? [:]
        
        for ingredient in ingredients {
            if recipeTodos[String(ingredient)] == nil {
                recipeTodos[String(ingredient)] = false
            }
        }
        
        todos[recipeKey] = recipeTodos
        try await saveToFile()
    }
    
    func resetTodos(for recipeID: Int64) async throws {
        await loadFromFile()
        todos[String(recipeID)] = [:]
        try await saveToFile()
    }
    
    func clearAllTodos() async throws {
        todos = [:]
        try await saveToFile()
    }
} 
