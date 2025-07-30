//
//  Service.swift
//  PuHaHang
//
//  Created by 디해 on 7/13/25.
//

import Audio
import Dependencies
import Foundation

extension AudioServiceKey: @retroactive DependencyKey {
    public static let liveValue: any AudioService = AudioServiceImpl()
}
