//
//  MockIntroRepository.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

struct MockIntroRepository: IntroRepository {
    func fetchIntro() async throws -> Intro {
        return Intro(
            recommendVersion: "테스트 버전",
            minVersion: "테스트 버전"
        )
    }
}
