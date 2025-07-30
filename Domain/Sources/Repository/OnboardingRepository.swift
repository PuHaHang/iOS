//
//  OnboardingRepository.swift
//  Domain
//
//  Created by 디해 on 7/15/25.
//

import Foundation

public protocol OnboardingRepository {
    func isFirstLaunch() -> Bool
    func isFirstCooking() -> Bool
    func setFirstLaunchCompleted()
    func setFirstCookingCompleted()
    func fetchOnboardingImage() async throws -> URL
}
