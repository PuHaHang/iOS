//
//  OnboardingDataSourceImpl.swift
//  Data
//
//  Created by 디해 on 7/15/25.
//

import Foundation

public struct OnboardingDataSourceImpl: OnboardingDataSource {
    private let launchOnboardingKey = "onboarding_launch"
    
    public init() { }
    
    public func getIsFirstLaunch() -> Bool {
        UserDefaults.standard.object(forKey: launchOnboardingKey) as? Bool ?? true
    }
    
    public func setFirstLaunchCompleted() {
        UserDefaults.standard.set(false, forKey: launchOnboardingKey)
    }
}
