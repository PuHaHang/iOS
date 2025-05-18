//
//  IntroRepositoryKey.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Dependencies
import Foundation

private enum IntroRepositoryKey: DependencyKey {
    static let liveValue: IntroRepository = LiveIntroRepository(dataSource: MockIntroDataSource())
}

extension DependencyValues {
    var introRepository: IntroRepository {
        get { self[IntroRepositoryKey.self] }
        set { self[IntroRepositoryKey.self] = newValue }
    }
}
