import Foundation

public protocol LocaleProvider {
    func getCurrentRegion() -> String
    func getCurrentLanguage() -> String
}

public struct LocaleProviderImpl: LocaleProvider {
    public init() {}
    
    public func getCurrentRegion() -> String {
        Locale.current.region?.identifier ?? "KR"
    }
    
    public func getCurrentLanguage() -> String {
        Locale.current.language.languageCode?.identifier ?? "ko"
    }
}
