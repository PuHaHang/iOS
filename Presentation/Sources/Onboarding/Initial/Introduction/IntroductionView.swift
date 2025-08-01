//
//  IntroductionView.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import AVFoundation
import ComposableArchitecture
import Shared
import SwiftUI

struct IntroductionView: View {
    @Bindable var store: StoreOf<IntroductionReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            Text(store.titleText)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(AppColor.Text.main)
                .multilineTextAlignment(.center)
                .padding(.top, 80)
                .padding(.bottom, 15)
            
            Text(store.subTitleText)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundStyle(AppColor.Text.information)
            
            Spacer()
            
            LoopingPlayerView(videoName: "example", videoType: "mp4")
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .aspectRatio(9/16, contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 400)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                .allowsHitTesting(false)
            
            Spacer()
            
            RoundedButton(title: LocalizationHelper.onboardingIntroductionNext) {
                store.send(.didTapNextButton)
            }
            .padding(.bottom, 50)
        }
        .toolbar(.hidden)
    }
}

struct LoopingPlayerView: UIViewRepresentable {
    let videoName: String
    let videoType: String

    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(videoName: videoName, videoType: videoType)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }

    class PlayerUIView: UIView {
        private var player: AVQueuePlayer?
        private var playerLooper: AVPlayerLooper?

        init(videoName: String, videoType: String) {
            super.init(frame: .zero)
            setupPlayer(videoName: videoName, videoType: videoType)
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

        private func setupPlayer(videoName: String, videoType: String) {
            guard let path = Bundle.main.path(forResource: videoName, ofType: videoType) else { return }
            let url = URL(fileURLWithPath: path)
            let asset = AVURLAsset(url: url)
            let item = AVPlayerItem(asset: asset)

            let player = AVQueuePlayer()
            let looper = AVPlayerLooper(player: player, templateItem: item)

            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resizeAspectFill
            layer.addSublayer(playerLayer)

            self.player = player
            self.playerLooper = looper

            player.isMuted = true
            player.play()
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            layer.sublayers?.first?.frame = bounds
        }
    }
}
