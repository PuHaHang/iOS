//
//  TimerView.swift
//  Presentation
//
//  Created by 디해 on 7/5/25.
//

import ComposableArchitecture
import SwiftUI

struct TimerView: View {
    @Bindable var store: StoreOf<TimerReducer>
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    store.send(.didTapPlayerBackground)
                }
            
            switch store.timerState {
            case .setting:
                TimerSettingView(store: store)
            case .running:
                TimerRunningView(store: store)
            case .finished:
                TimerFinishedView(store: store)
            }
        }
    }
    
    private struct TimerSettingView: View {
        @Bindable var store: StoreOf<TimerReducer>

        var body: some View {
            VStack(spacing: 20) {
                Text("타이머 설정")
                    .font(.system(size: 20))
                    .fontWeight(.bold)

                HStack(spacing: 20) {
                    Picker("분", selection: $store.minutes.sending(\.minutesChanged)) {
                        ForEach(0..<60) { Text("\($0)분") }
                    }
                    .pickerStyle(WheelPickerStyle())

                    Picker("초", selection: $store.seconds.sending(\.secondsChanged)) {
                        ForEach(0..<60) { Text("\($0)초") }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .frame(height: 150)

                RoundedButton(title: "설정하기") {
                    store.send(.startTimer)
                }
            }
            .frame(width: 300)
            .padding(27)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.white)
                    .shadow(radius: 10)
            )
            .padding()
        }
    }
    
    private struct TimerRunningView: View {
        @Bindable var store: StoreOf<TimerReducer>
        
        var body: some View {
            VStack(spacing: 20) {
                Text("남은 시간")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Text(store.timeString)
                    .font(.system(size: 50, weight: .bold, design: .monospaced))
                
                RoundedButton(title: "취소") {
                    store.send(.didTapCancelButton)
                }
            }
            .frame(width: 300)
            .padding(27)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.white)
                    .shadow(radius: 10)
            )
            .padding()
        }
    }
    
    private struct TimerFinishedView: View {
        @Bindable var store: StoreOf<TimerReducer>
        
        var body: some View {
            VStack(spacing: 20) {
                Image("timer_icon")
                
                Text("타이머가 종료되었어요.")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                RoundedButton(title: "확인") {
                    store.send(.didTapConfirmButton)
                }
            }
            .frame(width: 300)
            .padding(27)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.white)
                    .shadow(radius: 10)
            )
            .padding()
        }
    }
}
