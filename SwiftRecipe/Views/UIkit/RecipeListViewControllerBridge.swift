
import SwiftUI

struct RecipeListViewControllerBridge: UIViewControllerRepresentable {

    let navController = UINavigationController()

    func makeUIViewController(context: Context) -> UINavigationController {
        let viewController = RecipeListViewController()
        
        navController.addChild(viewController)

        return navController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}
