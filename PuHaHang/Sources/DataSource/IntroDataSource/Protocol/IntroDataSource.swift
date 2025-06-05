//
//  IntroDataSource.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import Foundation

protocol IntroDataSource {
    func fetchVersionRequirement() async throws -> VersionRequirementDTO
}
