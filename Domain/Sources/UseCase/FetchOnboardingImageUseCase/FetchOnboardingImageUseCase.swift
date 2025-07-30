//
//  FetchOnboardingImageUseCase.swift
//  Domain
//
//  Created by 디해 on 7/15/25.
//

import Foundation

public protocol FetchOnboardingImageUseCase {
    func execute() async throws -> Result<URL, Error>
} 
