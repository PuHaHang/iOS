//
//  FetchOnboardingImageUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 7/15/25.
//

import Foundation

public struct FetchOnboardingImageUseCaseImpl: FetchOnboardingImageUseCase {
    private let onboardingRepository: OnboardingRepository
    
    public init(onboardingRepository: OnboardingRepository) {
        self.onboardingRepository = onboardingRepository
    }
    
    public func execute() async throws -> Result<URL, Error> {
        do {
            let imageURL = try await onboardingRepository.fetchOnboardingImage()
            return .success(imageURL)
        } catch {
            return .failure(error)
        }
    }
} 
