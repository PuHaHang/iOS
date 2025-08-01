//
//  TimerReducer.swift
//  Presentation
//
//  Created by 디해 on 7/5/25.
//

import ComposableArchitecture
import Foundation
import Logger

@Reducer
struct TimerReducer {
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.logger) var logger
    
    @ObservableState
    struct State {
        var timerState: TimerState
        var minutes: Int = 1
        var seconds: Int = 0
        var remainingTime: Int = 0
        
        var timeString: String {
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    enum Action {
        case didTapPlayerBackground
        case didTapCancelButton
        case didTapConfirmButton
        case minutesChanged(Int)
        case secondsChanged(Int)
        case startTimer
        case tick
        case stopTimer
    }
    
    enum CancelID { case timer }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .didTapPlayerBackground:
                return .run { _ in await dismiss() }
                
            case .didTapCancelButton:
                logger.track(.timerCancelButton)
                return .send(.stopTimer)
                
            case .didTapConfirmButton:
                logger.track(.timerConfirmButton)
                return .send(.stopTimer)
                
            case .minutesChanged(let minutes):
                state.minutes = minutes
                return .none
                
            case .secondsChanged(let seconds):
                state.seconds = seconds
                return .none
                
            case .startTimer:
                state.timerState = .running
                state.remainingTime = state.minutes * 60 + state.seconds
                
                return .run { send in
                    while true {
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                        await send(.tick)
                    }
                }
                .cancellable(id: CancelID.timer)
                
            case .tick:
                guard state.remainingTime > 0 else {
                    state.timerState = .finished
                    return .none
                }
                state.remainingTime -= 1
                return .none
                
            case .stopTimer:
                return .concatenate(
                    .cancel(id: CancelID.timer),
                    .run { _ in await dismiss() }
                )
            }
        }
    }
}

extension TimerReducer {
    enum TimerState {
        case setting
        case running
        case finished
    }
}
