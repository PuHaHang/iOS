//
//  CookingView.swift
//  PuHaHang
//
//  Created by 디해 on 6/11/25.
//

import ComposableArchitecture
import SwiftUI
import YouTubePlayerKit

struct CookingView: View {
    @Bindable var store: StoreOf<CookingReducer>
    
    var body: some View {
        ZStack {
            CookingMainView(store: store)
                .zIndex(0)
            
            if store.isPlayerPresented {
                CookingPlayerView(store: store)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: store.isPlayerPresented)
        .navigationTitle(store.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

extension CookingView {
    private struct CookingMainView: View {
        @Bindable var store: StoreOf<CookingReducer>
        
        var body: some View {
            VStack {
                Spacer()

                CookingStepView(
                    title: store.steps[store.currentStep].stepTitle,
                    content: store.steps[store.currentStep].stepContent
                )
                .padding(.horizontal, 30)
                
                Spacer()
                
                StepControlBar(
                    isPlayEnabled: store.reference.hasExternalLink,
                    onPrevious: {
                        store.send(.didTapPrevButton)
                    },
                    onPlay: {
                        store.send(.didTapSourceButton)
                    },
                    onNext: {
                        store.send(.didTapNextButton)
                    }
                )
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
        }
    }
    
    private struct CookingPlayerView: View {
        @Bindable var store: StoreOf<CookingReducer>
        
        var body: some View {
            ZStack {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture {
                        store.send(.didTapPlayerBackground)
                    }
                
                VStack {
                    Spacer().frame(height: 40)
                    
                    if case .youtube(let url) = store.reference {
                        CookingYoutubePlayerView(store: store, url: url)
                            .frame(width: 300, height: 169)
                    } else if case .shorts(let url) = store.reference {
                        CookingYoutubePlayerView(store: store, url: url)
                            .frame(width: 300, height: 533)
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    private struct CookingYoutubePlayerView: View {
        @Bindable var store: StoreOf<CookingReducer>
        let player: YouTubePlayer
        
        init(store: StoreOf<CookingReducer>, url: URL) {
            let py = YouTubePlayer(url: url)
            py.parameters = .init(
                autoPlay: true,
                startTime: store.startTime,
                endTime: store.endTime,
                showControls: false
            )
            self.player = py
            self.store = store
        }
        
        var body: some View {
            YouTubePlayerView(player)
                .cornerRadius(20)
                .shadow(radius: 10)
                .onReceive(player.currentTimePublisher) { currentTime in
                    if currentTime >= store.endTime {
                        store.send(.endTimeReached)
                    }
                }
        }
    }
    
    private struct CookingStepView: View {
        let title: String
        let content: String
        
        var body: some View {
            VStack(spacing: 10) {
                Text(title)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundStyle(AppColor.Text.step)
                
                Text(content)
                    .font(.system(size: 35))
                    .fontWeight(.heavy)
                    .foregroundStyle(AppColor.Text.normalInstruction)
            }
        }
    }
    
    private struct StepControlBar: View {
        let isPlayEnabled: Bool
        
        let onPrevious: () -> Void
        let onPlay: () -> Void
        let onNext: () -> Void

        var body: some View {
            HStack(spacing: 10) {
                RoundedButton(
                    title: "이전",
                    isEnabled: true,
                    action: onPrevious
                )
                RoundedButton(
                    systemImageName: "play.fill",
                    isEnabled: isPlayEnabled,
                    action: onPlay
                )
                RoundedButton(
                    title: "다음",
                    isEnabled: true,
                    action: onNext
                )
            }
        }
    }
}
