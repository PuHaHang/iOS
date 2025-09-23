import Foundation

public struct ClearRecipePreviewCacheUseCaseImpl: ClearRecipePreviewCacheUseCase {
    private let recipePreviewRepository: RecipePreviewRepository
    
    public init(recipePreviewRepository: RecipePreviewRepository) {
        self.recipePreviewRepository = recipePreviewRepository
    }
    
    public func execute() async -> Result<Void, Error> {
        do {
            try await recipePreviewRepository.clearCache()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
} 
