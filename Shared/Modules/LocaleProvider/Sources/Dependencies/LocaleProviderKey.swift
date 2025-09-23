//
//  LocaleProviderKey.swift
//  LocaleProvider
//
//  Created by 디해 on 7/24/25.
//

import Dependencies
import Foundation

public enum LocaleProviderKey: TestDependencyKey {
    public static let testValue: LocaleProvider = EmptyLocaleProvider()
}

public extension DependencyValues {
    var localeProvider: LocaleProvider {
        get { self[LocaleProviderKey.self] }
        set { self[LocaleProviderKey.self] = newValue }
    }
}
