import Foundation

final class RecipeListViewModelUIKit {
    
    private let recipeService: RecipeService
    
    // TODO: - #2:  In RecipeListViewModelUIKit: publish search results to the RecipeListViewController using the
    //  RecipeService. The screen should show a blank page when the query is empty, a loading
    //  indicator while the page is loading, and a list of results when the repository returns data.
    //  See the screenshots in README.md.

    init(recipeService: RecipeService = RecipeService()) {
        self.recipeService = recipeService
    }

    struct State {
        let isLoading: Bool
        let statusMessage: String?
        let recipes: [Recipe]
        
        init(
            isLoading: Bool = false,
            statusMessage: String? = nil,
            recipes: [Recipe]? = nil
        ) {
            self.isLoading = isLoading
            self.statusMessage = statusMessage
            self.recipes = recipes ?? []
        }
        
        static let `default` = State()
        static let loading = State(isLoading: true)
    }
}
