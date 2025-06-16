//
//  FetchIntroUseCaseKey.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import Dependencies
import Foundation

private enum FetchIntroUseCaseKey: DependencyKey {
    static let liveValue: FetchIntroUseCase = LiveFetchIntroUseCase(
        versionRepository: MockIntroRepository()
    )
}

extension DependencyValues {
    var fetchIntroUseCase: FetchIntroUseCase {
        get { self[FetchIntroUseCaseKey.self] }
        set { self[FetchIntroUseCaseKey.self] = newValue }
    }
}
