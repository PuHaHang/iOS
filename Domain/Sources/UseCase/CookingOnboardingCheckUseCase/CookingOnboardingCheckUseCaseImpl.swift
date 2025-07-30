//
//  CookingOnboardingCheckUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 7/22/25.
//

import Foundation

public struct CookingOnboardingCheckUseCaseImpl: CookingOnboardingCheckUseCase {
    private let onboardingRepository: OnboardingRepository
    
    public init(onboardingRepository: OnboardingRepository) {
        self.onboardingRepository = onboardingRepository
    }
    
    public func execute() -> Bool {
        onboardingRepository.isFirstCooking()
    }
}
