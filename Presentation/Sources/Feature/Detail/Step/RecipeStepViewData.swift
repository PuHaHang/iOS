//
//  RecipeStepViewData.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import Foundation

struct RecipeStepViewData: Identifiable {
    let id: UUID
    let stepTitle: String
    let stepContent: String
    let timeline: TimeLineViewData
}
