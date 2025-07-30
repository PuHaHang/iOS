//
//  EmptyOnboardingRepository.swift
//  Data
//
//  Created by 디해 on 7/15/25.
//

import Domain
import Foundation

struct EmptyOnboardingRepository: OnboardingRepository {
    func isFirstLaunch() -> Bool {
        throwUnimplemented()
    }
    
    func isFirstCooking() -> Bool {
        throwUnimplemented()
    }
    
    func setFirstLaunchCompleted() {
        throwUnimplemented()
    }
    
    func setFirstCookingCompleted() {
        throwUnimplemented()
    }
    
    func fetchOnboardingImage() async throws -> URL {
        throwUnimplemented()
    }
}
