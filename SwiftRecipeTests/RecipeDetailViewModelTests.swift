
import Testing
@testable import SwiftRecipe
import Foundation

@MainActor
struct RecipeDetailViewModelTests {
    
    @Test func testInitialStateIsLoading() {
        let sut = RecipeDetailViewModel(
            recipe: SwiftRecipe.Recipe.preview,
            service: MockRecipeService(recipe: SwiftRecipe.Recipe.preview)
        )
        
        #expect(sut.state == .loading)
    }
    
    @Test func test_whenRequestIsSuccessful_stateIsSuccess() async throws {
        let sut = RecipeDetailViewModel(
            recipe: SwiftRecipe.Recipe.preview,
            service: MockRecipeService(recipe: SwiftRecipe.Recipe.preview)
        )
        await sut.fetchRecipeDetails()
        
        #expect(sut.state == .success(SwiftRecipe.Recipe.preview))
    }
    
    @Test func test_whenRequestFails_stateIsFailure() async throws {
        let sut = RecipeDetailViewModel(
            recipe: SwiftRecipe.Recipe.preview,
            service: MockRecipeService(apiError: .unknownError)
        )
        await sut.fetchRecipeDetails()
        
        #expect(sut.state == .failure("Oops, something went wrong."))
    }
    
    @Test func testGetRatingStarImage() {
        let fullStar = "star.fill"
        let halfStar = "star.leadinghalf.filled"
        let emptyStar = "star"
        var starsStrings: [String] = []
        
        let sut1 = RecipeDetailViewModel(
            recipe: SwiftRecipe.Recipe.preview, // Ranking = 99.9
            service: MockRecipeService()
        )
        let expectedResult1: [String] = [fullStar, fullStar, fullStar, fullStar, halfStar]
        for i in 1...5 {
            starsStrings.append(sut1.getRatingStarImage(i))
        }
        #expect(starsStrings == expectedResult1)
        
        starsStrings.removeAll()
        let sut2 = RecipeDetailViewModel(
            recipe: Recipe(
                id: "35107",
                publisher: "Closet Cooking",
                title: "Bacon Double Cheese Burger Dip",
                sourceURL: URL(string: "http://www.closetcooking.com/2012/01/bacon-double-cheese-burger-dip.html")!,
                imageURL: URL(string: "http://forkify-api.herokuapp.com/images/Bacon2BDouble2BCheese2BBurger2BDip2B5002B3557cdaa745d.jpg")!,
                socialRank: 50,
                publisherURL: URL(string: "http://closetcooking.com")!,
                ingredients: nil
            ),
            service: MockRecipeService()
        )
        let expectedResult2: [String] = [fullStar, fullStar, halfStar, emptyStar, emptyStar]
        for i in 1...5 {
            starsStrings.append(sut2.getRatingStarImage(i))
        }
        #expect(starsStrings == expectedResult2)
    }
}
