
import SwiftUI

//TODO: - #5 Implement the Details screen using RecipeDetailViewModel

struct RecipeDetailView: View {
    var viewModel: RecipeDetailViewModel
    
    var body: some View {
        EmptyView()
    }
}

#Preview {
    RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: .preview))
}
