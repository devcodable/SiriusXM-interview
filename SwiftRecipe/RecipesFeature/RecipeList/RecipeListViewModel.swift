
import Foundation
import SwiftUI
import Combine

@MainActor
final class RecipeListViewModel: ObservableObject {
    
    @Published var state: State
    @Published var userPrompt: String
    
    private let recipeService: RecipeServiceInterface

    init(recipeService: RecipeServiceInterface = RecipeService()) {
        self.state = State()
        self.userPrompt = ""
        self.recipeService = recipeService
    }
    
    func handleUserPrompt() async {
        if userPrompt.isEmpty {
            state = State()
        } else {
            do {
                state = .loading
                let result = try await recipeService.searchRecipe(query: userPrompt)
                state = .results(recipes: result.recipes)
            } catch {
                print("Error while fetching query for \(userPrompt). \n Error description: \(error.localizedDescription)")
                state = .error(message: "No results for \(userPrompt)")
            }
        }
    }
    
    enum State: Equatable {
        case loading
        case results(recipes: [Recipe])
        case error(message: String)
        
        init() {
            self = .results(recipes: [])
        }
    }
}
