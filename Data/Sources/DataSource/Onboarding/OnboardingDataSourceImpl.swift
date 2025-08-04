//
//  OnboardingDataSourceImpl.swift
//  Data
//
//  Created by 디해 on 7/15/25.
//

import Foundation
import Minifire

public struct OnboardingDataSourceImpl: OnboardingDataSource {
    private let launchOnboardingKey = "onboarding_launch"
    private let cookingOnboardingKey = "onboarding_cooking"
    
    public init() {}
    
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
    
    public func fetchOnboardingImage() async throws -> String {
        let request = MFRequest(url: "http://121.157.24.40/api/v1/onboarding")
            .get()
            .validate()
        
        let response = try await MF
            .setErrorDecoder(ServerDecoder.shared)
            .requestString(request)
        
        return response.value
    }
}
