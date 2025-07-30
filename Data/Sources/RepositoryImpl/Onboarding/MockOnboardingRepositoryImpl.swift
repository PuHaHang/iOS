//
//  MockOnboardingRepositoryImpl.swift
//  Data
//
//  Created by 디해 on 7/27/25.
//

import Domain
import Foundation

public struct MockOnboardingRepositoryImpl: OnboardingRepository {
    public init() {}
    
    public func isFirstLaunch() -> Bool {
        true
    }
    
    public func isFirstCooking() -> Bool {
        true
    }
    
    public func setFirstLaunchCompleted() {
    }
    
    public func setFirstCookingCompleted() {
    }
    
    public func fetchOnboardingImage() async throws -> URL {
        URL(string: "https://images.unsplash.com/photo-1600891964599-f61ba0e24092")!
    }
}
