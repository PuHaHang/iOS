//
//  LaunchOnboardingCheckUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 7/15/25.
//

import Foundation

public struct LaunchOnboardingCheckUseCaseImpl: LaunchOnboardingCheckUseCase {
    private let onboardingRepository: OnboardingRepository
    
    public init(onboardingRepository: OnboardingRepository) {
        self.onboardingRepository = onboardingRepository
    }
    
    public func execute() -> Bool {
        onboardingRepository.isFirstLaunch()
    }
}
