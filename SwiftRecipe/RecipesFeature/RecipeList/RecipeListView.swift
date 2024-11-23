
import SwiftUI
import Combine
import Foundation

struct RecipeListView: View {
    @ObservedObject private var viewModel = RecipeListViewModel()

    var body: some View {
        NavigationView {
            VStack {
               switch viewModel.state {
               case .loading:
                   ProgressView()
               case .error(message: let message):
                   Text(message)
                       .padding(.top, 40)
                   Spacer()
               case .results(recipes: let recipes):
                   ForEach(recipes) { recipe in
                       //                           NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                       //                               Text(recipe.title)
                       //                           }
                       Text(recipe.title)
                   }
                   
                }
            }
            .navigationTitle("Recipes")
        }
        .searchable(text: $viewModel.userPrompt, prompt: "Search recipes...")
        .onChange(of: viewModel.userPrompt) {
            Task {
                await viewModel.searchRecipes()
            }
        }
    }
}
