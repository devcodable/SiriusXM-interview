import UIKit

final class RecipeListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = RecipeListViewModelUIKit()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - #3: Display search results from RecipeListViewModelUIKit.
        //  - perform the search using the view model
        //  - populate a tableView
        //  - The view should match the image in screenshots/uikit_search_results.png
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension RecipeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0 // TODO
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell() // TODO
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }
}

// MARK: - UISearchBarDelegate

extension RecipeListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // TODO
    }
}
