//
//  OnboardingDataSource.swift
//  Data
//
//  Created by 디해 on 7/15/25.
//

import Foundation

public protocol OnboardingDataSource {
    func getIsFirstLaunch() -> Bool
    func getIsFirstCooking() -> Bool
    func setFirstLaunchCompleted()
    func setFirstCookingCompleted()
    func fetchOnboardingImage() async throws -> String
}
