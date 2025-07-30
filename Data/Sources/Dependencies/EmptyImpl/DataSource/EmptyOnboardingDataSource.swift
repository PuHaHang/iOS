//
//  EmptyOnboardingDataSource.swift
//  Data
//
//  Created by 디해 on 7/15/25.
//

import Foundation

public struct EmptyOnboardingDataSource: OnboardingDataSource {
    public func getIsFirstLaunch() -> Bool {
        throwUnimplemented()
    }
    
    public func getIsFirstCooking() -> Bool {
        throwUnimplemented()
    }
    
    public func setFirstLaunchCompleted() {
        throwUnimplemented()
    }
    
    public func setFirstCookingCompleted() {
        throwUnimplemented()
    }
}
