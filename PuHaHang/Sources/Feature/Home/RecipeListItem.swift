//
//  RecipeListItem.swift
//  PuHaHang
//
//  Created by 디해 on 6/7/25.
//

import UIKit

struct RecipeListItem: Equatable, Identifiable {
    let id: UUID = UUID()
    let thumbnail: UIImage
    let title: String
    let serving: String
    let ingredients: String
}
