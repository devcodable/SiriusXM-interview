
import Foundation

//TODO: - #4 Implement Details ViewModel using RecipeService

@MainActor
final class RecipeDetailViewModel {
    let recipe: Recipe
    private let service = RecipeService()

    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func fetchRecipeDetails() async {}
}
