
import Foundation
@testable import SwiftRecipe

struct MockRecipeService: RecipeServiceInterface {
    let recipe: SwiftRecipe.Recipe
    let apiError: SwiftRecipe.APIError?
    
    init(
        recipe: SwiftRecipe.Recipe = SwiftRecipe.Recipe.preview,
        apiError: SwiftRecipe.APIError? = nil
    ) {
        self.recipe = recipe
        self.apiError = apiError
    }
    
    func searchRecipe(query: String) async throws(SwiftRecipe.APIError) -> SwiftRecipe.SearchResponse {
        if let apiError {
            throw apiError
        } else {
            return SwiftRecipe.SearchResponse(count: 1, recipes: [recipe])
        }
    }
    
    func fetchRecipeDetails(id: String) async throws(SwiftRecipe.APIError) -> SwiftRecipe.Recipe {
        if let apiError {
            throw apiError
        } else {
            return SwiftRecipe.Recipe.preview
        }
    }
}
