import Foundation

//TODO: - #4 Implement Details ViewModel using RecipeService

final class RecipeDetailViewModelUIKit {
    
    // MARK: - Properties
    
    private(set) var recipe: Recipe
    private let service: RecipeService

    // MARK: - Initializer
    
    init(recipe: Recipe, service: RecipeService = RecipeService()) {
        self.recipe = recipe
        self.service = service
    }
    
    // MARK: - Fetch Recipe Details
    
    func fetchRecipeDetails() {}
}
