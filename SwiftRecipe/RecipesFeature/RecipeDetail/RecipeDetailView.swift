
import SwiftUI

//TODO: - #5 Implement the Details screen using RecipeDetailViewModel

struct RecipeDetailView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: viewModel.recipe.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .clipped()
            .overlay {
                publisherBanner
            }
            
            ScrollView {
                Group {
                    socialRankView
                    
                    switch viewModel.state {
                    case .loading:
                        ProgressView()
                            .padding(32)
                    case let .success(recipeDetails):
                        buildIngredientsView(recipeDetails.ingredients ?? [])
                    case let .failure(message):
                        Text(message)
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.automatic)
            
            Spacer()
            
            viewRecipeButton
                .padding(.horizontal, 16)
        }
        .navigationTitle(viewModel.recipe.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchRecipeDetails()
        }
        .animation(.easeInOut, value: viewModel.state)
    }
    
    private var publisherBanner: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Published by ")
                +
                Text(.init("[\(viewModel.recipe.publisher)](\(viewModel.recipe.publisherURL.absoluteString))"))
                
                Spacer()
            }
            .padding(16)
            .background {
                Color.gray
                    .opacity(0.8)
            }
        }
    }
    
    private var socialRankView: some View {
        HStack(spacing: 12) {
            Text("Social Rank: ")
                .bold()
            
            Spacer()
            
            ForEach(1...5, id: \.self) { i in
                Image(systemName: viewModel.getRatingStarImage(i))
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                    .foregroundStyle(Color.yellow)
            }
        }
    }
    
    private func buildIngredientsView(_ ingredients: [String]) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Ingredients:")
                    .bold()
                Spacer()
            }
            
            ForEach(0..<ingredients.count, id: \.self) { i in
                Text("- " + ingredients[i])
                    .padding(.leading, 16)
            }
        }
    }
    
    private var viewRecipeButton: some View {
        Button {
            openURL(viewModel.recipe.sourceURL)
        } label: {
            HStack {
                Spacer()
                Text("View Full Recipe")
                    .bold()
                    .foregroundColor(.blue)
                    .padding(16)
                Spacer()
            }
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
