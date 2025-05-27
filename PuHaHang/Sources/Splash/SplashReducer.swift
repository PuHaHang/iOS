//
//  SplashReducer.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SplashReducer {
    @Dependency(\.introRepository) var introRepository
    
    @ObservableState
    struct State {
        var introRoadState: IntroRoadState = .idle
    }
    
    enum Action {
        case onAppear
        case introResponse(Result<Intro, Error>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return reduceOnAppear()
                
            case .introResponse(let result):
                return reduceIntroResponse(&state, result: result)
            }
        }
    }
}

private extension SplashReducer {
    func reduceOnAppear() -> Effect<Action> {
        .run { send in
            do {
                let intro: Intro = try await introRepository.fetchIntro()
                await send(.introResponse(.success(intro)))
            } catch {
                await send(.introResponse(.failure(error)))
            }
        }
    }
    
    func reduceIntroResponse(
        _ state: inout SplashReducer.State,
        result: Result<Intro, Error>
    ) -> Effect<Action> {
        switch result {
        case .success(let intro):
            state.introRoadState = .success(intro)
            
        case .failure(let error):
            state.introRoadState = .failure(error)
        }
        
        return .none
    }
}
