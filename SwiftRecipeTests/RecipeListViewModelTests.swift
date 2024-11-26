
import Testing
@testable import SwiftRecipe

@MainActor
struct RecipeListViewModelTests {
    
    @Test func testInitialStateIsEmpty() {
        let sut = RecipeListViewModel(recipeService: MockRecipeService(recipe: SwiftRecipe.Recipe.preview))
        
        #expect(sut.state == .results(recipes: []))
    }
    
    @Test func test_whenHavingValidUserPrompt_stateIsResults() async throws {
        let sut = RecipeListViewModel(recipeService: MockRecipeService(recipe: SwiftRecipe.Recipe.preview))
        
        sut.userPrompt = "Pizza"
        await sut.handleUserPrompt()
        #expect(sut.state == .results(recipes: [SwiftRecipe.Recipe.preview]))
    }
    
    @Test func test_whenDeletingUserPrompt_stateIsEmpty() async throws {
        let sut = RecipeListViewModel(recipeService: MockRecipeService(recipe: SwiftRecipe.Recipe.preview))
        
        sut.userPrompt = "Pizza"
        await sut.handleUserPrompt()
        #expect(sut.state == .results(recipes: [SwiftRecipe.Recipe.preview]))
        
        sut.userPrompt = ""
        await sut.handleUserPrompt()
        #expect(sut.state == .results(recipes: []))
    }
    
    @Test func test_whenHavingInvalidUserPrompt_stateIsError() async throws {
        let sut = RecipeListViewModel(recipeService: MockRecipeService(apiError: APIError.unknownError))
        
        sut.userPrompt = "Pizz"
        await sut.handleUserPrompt()
        #expect(sut.state == .error(message: "No results for Pizz"))
    }
}
