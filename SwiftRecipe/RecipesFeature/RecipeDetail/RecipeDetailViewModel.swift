
import Foundation

//TODO: - #4 Implement Details ViewModel using RecipeService

@MainActor
final class RecipeDetailViewModel: ObservableObject {
    let recipe: Recipe
    private let service = RecipeService()
    
    @Published var state: State

    init(recipe: Recipe) {
        self.recipe = recipe
        self.state = .loading
    }
    
    func fetchRecipeDetails() async {
        do {
            let result = try await service.fetchRecipeDetails(id: recipe.id)
            state = .success(result)
        } catch {
            print("Error while fetching query for recipe with id: \(recipe.id). \n Error description: \(error.localizedDescription)")
            state = .failure("Oops, something went wrong.")
        }
    }
    
    func getRatingStarImage(_ starNumber: Int) -> String {
        let fullStar = "star.fill"
        let halfStar = "star.leadinghalf.filled"
        let emptyStar = "star"
        
        if starNumber * 20 <= Int(recipe.socialRank) {
            return fullStar
        } else if starNumber * 20 <= Int(recipe.socialRank) + 10 {
            return halfStar
        } else {
            return emptyStar
        }
    }
    
    enum State: Equatable {
        case loading
        case success(Recipe)
        case failure(String)
    }
}
