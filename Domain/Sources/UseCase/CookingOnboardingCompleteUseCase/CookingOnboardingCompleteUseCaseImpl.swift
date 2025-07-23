//
//  CookingOnboardingCompleteUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 7/22/25.
//

import Foundation

public struct CookingOnboardingCompleteUseCaseImpl: CookingOnboardingCompleteUseCase {
    private let onboardingRepository: OnboardingRepository
    
    public init(onboardingRepository: OnboardingRepository) {
        self.onboardingRepository = onboardingRepository
    }
    
    public func execute() {
        onboardingRepository.setFirstCookingCompleted()
    }
}
