import Foundation

public protocol ClearRecipePreviewCacheUseCase {
    func execute() async -> Result<Void, Error>
} 
