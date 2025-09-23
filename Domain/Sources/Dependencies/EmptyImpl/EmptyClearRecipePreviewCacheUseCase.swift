import Foundation

struct EmptyClearRecipePreviewCacheUseCase: ClearRecipePreviewCacheUseCase {
    init() {}

    func execute() async -> Result<Void, Error> {
        return unimplementedFailure()
    }
} 
