//
//  CookingPlayerReducer.swift
//  Presentation
//
//  Created by 디해 on 7/4/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CookingPlayerReducer {
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State {
        let reference: ReferenceViewData
        let startTime: Measurement<UnitDuration>
        let endTime: Measurement<UnitDuration>
    }
    
    enum Action {
        case didTapPlayerBackground
        case endTimeReached
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapPlayerBackground:
                return .run { _ in
                    await dismiss()
                }
                
            case .endTimeReached:
                return .run { _ in
                    await dismiss()
                }
            }
        }
    }
}
