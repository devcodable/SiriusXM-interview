
import SwiftUI

@main
struct SwiftRecipeApp: App {
    var body: some Scene {
        WindowGroup {
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
