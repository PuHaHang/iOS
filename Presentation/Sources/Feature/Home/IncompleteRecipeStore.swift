//
//  IncompleteRecipeStore.swift
//  Presentation
//
//  Created by 디해 on 7/27/25.
//

import Dependencies
import Foundation

actor IncompleteRecipeStore<T: Hashable> {
    private var ids: Set<T>
    
    init(ids: Set<T> = []) {
        self.ids = ids
    }

    func set(_ ids: Set<T>) {
        self.ids = ids
    }
    
    func add(_ id: T) {
        self.ids.insert(id)
    }

    func remove(_ id: T) {
        self.ids.remove(id)
    }
    
    func remove(_ ids: [T]) {
        for id in ids {
            self.ids.remove(id)
        }
    }

    func get() -> [T] {
        Array(self.ids)
    }

    func isEmpty() -> Bool {
        self.ids.isEmpty
    }
}

enum IncompleteRecipeStoreKey: DependencyKey {
    static let liveValue = IncompleteRecipeStore<Int64>()
}

extension DependencyValues {
    var incompletedRecipeIDStore: IncompleteRecipeStore<Int64> {
        get { self[IncompleteRecipeStoreKey.self] }
        set { self[IncompleteRecipeStoreKey.self] = newValue }
    }
}
