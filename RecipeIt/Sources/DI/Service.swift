//
//  Service.swift
//  PuHaHang
//
//  Created by 디해 on 7/13/25.
//

import Audio
import Dependencies
import Foundation
import LocaleProvider
import Login
import Logger
import KeyChainHelper

extension AudioServiceKey: @retroactive DependencyKey {
    public static let liveValue: any AudioService = AudioServiceImpl()
}

extension LocaleProviderKey: @retroactive DependencyKey {
    public static let liveValue: any LocaleProvider = LocaleProviderImpl()
}

extension KeyChainHelperKey: @retroactive DependencyKey {
    public static let liveValue: any KeyChainHelper = KeyChainHelperImpl()
}

extension LoginManagerKey: @retroactive DependencyKey {
    public static let liveValue: any LoginManager = LoginManagerImpl()
}

extension LoggerKey: @retroactive DependencyKey {
    public static let liveValue: any Logger = AmplitudeLogger.shared
}
