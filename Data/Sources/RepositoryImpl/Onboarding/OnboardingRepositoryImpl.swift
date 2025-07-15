//
//  OnboardingRepositoryImpl.swift
//  Data
//
//  Created by 디해 on 7/15/25.
//

import Domain
import Foundation

public struct OnboardingRepositoryImpl: OnboardingRepository {
    private let dataSource: OnboardingDataSource

    public init(dataSource: OnboardingDataSource) {
        self.dataSource = dataSource
    }

    public func isFirstLaunch() -> Bool {
        dataSource.getIsFirstLaunch()
    }

    public func setFirstLaunchCompleted() {
        dataSource.setFirstLaunchCompleted()
    }
}
