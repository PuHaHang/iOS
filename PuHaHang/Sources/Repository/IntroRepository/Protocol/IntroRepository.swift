//
//  IntroRepository.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation

protocol IntroRepository {
    func fetchIntro() async throws -> Intro
}
