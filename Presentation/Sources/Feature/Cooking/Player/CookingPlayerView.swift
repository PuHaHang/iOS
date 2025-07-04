//
//  CookingPlayerView.swift
//  Presentation
//
//  Created by 디해 on 7/4/25.
//

import ComposableArchitecture
import SwiftUI
import YouTubePlayerKit

struct CookingPlayerView: View {
    @Bindable var store: StoreOf<CookingPlayerReducer>
    
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

extension CookingPlayerView {
    private struct CookingYoutubePlayerView: View {
        @Bindable var store: StoreOf<CookingPlayerReducer>
        let player: YouTubePlayer
        
        init(store: StoreOf<CookingPlayerReducer>, url: URL) {
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
}
