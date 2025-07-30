//
//  EmptyLocaleProvider.swift
//  LocaleProvider
//
//  Created by 디해 on 7/24/25.
//

import Foundation

public struct EmptyLocaleProvider: LocaleProvider {
    public func getCurrentRegion() -> String {
        throwUnimplemented()
    }
    
    public func getCurrentLanguage() -> String {
        throwUnimplemented()
    }
}
