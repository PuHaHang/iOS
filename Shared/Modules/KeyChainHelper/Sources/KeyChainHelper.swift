import Foundation

public protocol KeyChainHelper {
    @discardableResult
    func save(value: String, forKey key: String) -> Bool
    
    func get(forKey key: String) -> String?
    
    @discardableResult
    func delete(forKey key: String) -> Bool
}
