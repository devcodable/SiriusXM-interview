
import SwiftUI

@main
struct SwiftRecipeApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: - #1: choose a UI interface (feel free to change the order of the tabs)
            TabView {
                RecipeListView()
                    .tabItem {
                        Label("SwiftUI", systemImage: "swift")
                    }
                
                RecipeListViewControllerBridge()
                .tabItem {
                    Label("UIKit", systemImage: "square.stack.3d.down.forward")
                }
                
            }
        }
    }
}
