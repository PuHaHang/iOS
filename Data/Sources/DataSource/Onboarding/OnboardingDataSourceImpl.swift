//
//  OnboardingDataSourceImpl.swift
//  Data
//
//  Created by 디해 on 7/15/25.
//

import Foundation

public struct OnboardingDataSourceImpl: OnboardingDataSource {
    private let launchOnboardingKey = "onboarding_launch"
    private let cookingOnboardingKey = "onboarding_cooking"
    
    public init() { }
    
    public func getIsFirstLaunch() -> Bool {
        UserDefaults.standard.object(forKey: launchOnboardingKey) as? Bool ?? true
    }
    
    public func getIsFirstCooking() -> Bool {
        UserDefaults.standard.object(forKey: cookingOnboardingKey) as? Bool ?? true
    }
    
    public func setFirstLaunchCompleted() {
        UserDefaults.standard.set(false, forKey: launchOnboardingKey)
    }
    
    public func setFirstCookingCompleted() {
        UserDefaults.standard.set(false, forKey: cookingOnboardingKey)
    }
}
