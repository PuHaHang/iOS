//
//  FetchIntroUseCase.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import Foundation

protocol FetchIntroUseCase {
    func execute() async -> Result<Intro, Error>
}
