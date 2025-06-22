//
//  UseCase.swift
//  PuHaHang
//
//  Created by Jongchan Kim on 6/22/25.
//
import Foundation
import Domain
import Dependencies

// MARK: - IntroUseCase DI

private enum IntroUseCaseKey: DependencyKey {
    static let liveValue: IntroUseCase = {
        @Dependency(\.introRepository) var introRepository
        return IntroUseCaseImpl(introRepository: introRepository)
    }()
    
    #if DEBUG
    static let testValue: IntroUseCase = {
        @Dependency(\.introRepository) var introRepository
        return IntroUseCaseImpl(introRepository: introRepository)
    }()
    #endif
    
    static let previewValue: IntroUseCase = {
        @Dependency(\.introRepository) var introRepository
        return IntroUseCaseImpl(introRepository: introRepository)
    }()
}

extension DependencyValues {
    var introUseCase: IntroUseCase {
        get { self[IntroUseCaseKey.self] }
        set { self[IntroUseCaseKey.self] = newValue }
    }
}

