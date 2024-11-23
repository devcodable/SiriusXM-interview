
import SwiftUI
import Combine
import Foundation

struct RecipeListView: View {
    private var viewModel = RecipeListViewModel()

    var body: some View {
        NavigationView {
            // TODO: - #3: Display a search bar and a list of results.
            //  - perform the search using the view model
            //  - The view should match the image in screenshots/swiftui_search_results.png
            EmptyView()
            .navigationTitle("Recipes")
        }
    }
}
