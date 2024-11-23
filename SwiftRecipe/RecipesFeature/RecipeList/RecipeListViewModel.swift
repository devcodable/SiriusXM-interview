
import Foundation
import SwiftUI
import Combine

@MainActor final class RecipeListViewModel: ObservableObject {
    
    @Published var state: State
    @Published var userPrompt: String
    
    private let recipeService: RecipeService

    init(recipeService: RecipeService = RecipeService()) {
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
                print("Error while fetching query \(userPrompt). \n Error description: \(error.localizedDescription)")
                state = .error(message: "No results for \(userPrompt)")
            }
        }
    }
    
    enum State {
        case loading
        case results(recipes: [Recipe])
        case error(message: String)
        
        init() {
            self = .results(recipes: [])
        }
    }
}

extension RecipeService.APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest(let int):
            "Bad request: \(int)"
        case .invalidStatus:
            "Invalid status"
        case .networkError(let uRLError):
            "Network error: \(uRLError)"
        case .serviceError:
            "Service error"
        case .unableToDecodeResponse(let string):
            "Unable to decode response: \(string)"
        case .unknownError:
            "Unknown error"
        }
    }
}
