//
//  LocaleProviderKey.swift
//  LocaleProvider
//
//  Created by 디해 on 7/24/25.
//

import Dependencies
import Foundation

public enum LocaleProviderKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: LocaleProvider = EmptyLocaleProvider()
    #endif
}

public extension DependencyValues {
    var localeProvider: LocaleProvider {
        get { self[LocaleProviderKey.self] }
        set { self[LocaleProviderKey.self] = newValue }
    }
}
