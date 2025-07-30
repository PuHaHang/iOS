//
//  OnboardingImageDTO.swift
//  Data
//
//  Created by 디해 on 7/15/25.
//

import Foundation

public struct OnboardingImageDTO: Decodable {
    let image: String
}

extension OnboardingImageDTO {
    func toDomain() -> String {
        return image
    }
} 