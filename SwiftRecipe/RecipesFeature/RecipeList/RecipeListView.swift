
import SwiftUI
import Combine
import Foundation

struct RecipeListView: View {
    @ObservedObject private var viewModel = RecipeListViewModel()
    
    private let imageSize: CGFloat = 44
    
    private var dividerPadding: CGFloat {
        16 + imageSize + 8
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                searchBar
                    .padding([.horizontal, .top], 16)
                
                switch viewModel.state {
                case .loading:
                    Spacer()
                    ProgressView()
                    Spacer()
                case .error(message: let message):
                    Text(message)
                    Spacer()
                case .results(recipes: let recipes):
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(recipes) { recipe in
                                buildCell(recipe)
                                    .padding(.horizontal, 16)
                                
                                if recipe != recipes.last {
                                    Divider()
                                        .padding(.leading, dividerPadding)
                                }
                            }
                        }
                    }
                }
                Spacer(minLength: 0)
            }
            .navigationTitle("Recipes")
        }
    }
    
    private var searchBar: some View {
        TextField("Search recipes...", text: $viewModel.userPrompt)
            .textFieldStyle(.roundedBorder)
            .submitLabel(.search)
            .onSubmit {
                Task {
                    await viewModel.handleUserPrompt()
                }
            }
    }
    
    private func buildCell(_ recipe: Recipe) -> some View {
        HStack(alignment: .center, spacing: 8) {
            AsyncImage(url: recipe.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: imageSize, height: imageSize)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(.system(size: 17))
                
                Text(recipe.publisher)
                    .font(.caption)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(height: 12)
                .opacity(0.4)
        }
    }
}
