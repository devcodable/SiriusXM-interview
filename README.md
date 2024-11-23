# SiriusXM Take-Home Project

Welcome to the SiriusXM take-home project! This exercise is designed to evaluate your skills in Apple platform development. Please spend **no more than 4-6 hours** working on this project. We will evaluate whatever you're able to complete.


A great solution should show:
- A strong grasp of software patterns
- Best practices for Apple and Swift development, including code readability and maintainability
- Thoughtful approaches to error handling, user experience, and performance

In the in-person interview, you should be prepared to walk through your code and discuss your thought process.

## Project Setup

### Development Environment
- **Xcode Requirements:**
    - This starter project was developed in Xcode 16.0, in case you run into compatibility issues.
- **Frameworks**:
    - You can use either UIKit or SwiftUI. While most new code is written in SwiftUI, we maintain legacy UIKit-based code, so it is a plus if engineers are comfortable working with both frameworks.
    - For **SwiftUI**, use  `RecipeListView.swift` and `RecipeDetailView.swift`.
    - For **UIKit**, use the `RecipeListViewController.swift` and `RecipeDetailViewController.swift`.

## Product Requirements

### 1.  Search Screen
The search screen enables users to search for recipes and view results.

- **Input Field**: Display a search input field at the top of the screen.
- **Search Logic**:
    - If the query is empty, display a blank screen.
    - Show a **loading indicator** while search results are loading.
    - If no results are returned, display the message: **"No results for {query}"**.
    - If results are returned, display them in a list. Clicking an item should navigate to the details screen.
    - **Debounce** the search input by 300ms to limit API calls and improve performance.
- **UI Design**: Match the layout in these screenshot as closely as possible:

| |Empty State|No Results|Results|
|-|-|-|-|
|SwiftUI|![Empty State](screenshots/swiftui_search_empty_state.png)|![No Results](screenshots/swiftui_search_no_results.png)|![Search Results](screenshots/swiftui_search_results.png)|
|UIKit|![Empty State](screenshots/uikit_search_empty_state.png)|![No Results](screenshots/uikit_search_no_results.png)|![Search Results](screenshots/uikit_search_results.png)|


### 2.  Details Screen
The details screen displays more information about a recipe.

- **Loading Widget**: Display a loading indicator while the recipe details are loading.
- **UI Design**: Match the layout in this screenshot as closely as possible:

|SwiftUI Details|UIKit Details|
|-|-|
|![SwiftUI Details](screenshots/swiftui_details.png)|![UIKit Details](screenshots/uikit_details.png)|

## Tasks

Select either SwiftUI or UIKit, but not a combination.

In its initial state, the project will show two tabs with blank content. Follow the TODOs in the code.

The first TODO will ask you to choose the UI interface to work on. The subsequent TODOs will ask the following:

### SwiftUI

2. In RecipeListViewModel.swift: Implement the view model for the search screen. The screen should show a blank page when the query is empty, a loading widget while the page is loading, and a list of results when the repository returns data.
3. In RecipeListView.swift: Display a search bar and a list of results.
4. In RecipeDetailViewModel.swift: Implement the view model for the details screen.
5. Implement RecipeDetailView.swift: Display details for the recipe that was selected on the RecipeListView.

### UIKit

2. In RecipeListViewModelUIKit.swift: Implement the view model for the search screen. The screen should show a blank page when the query is empty, a loading widget while the page is loading, and a list of results when the repository returns data.
3. In RecipeListViewController.swift: Display a search bar and a list of results. 
4. In RecipeDetailViewController.swift: Implement the view model for the details screen.
5. In RecipeDetailViewModelUIkit.swift: Display details for the recipe that was selected on the RecipeListViewController.
