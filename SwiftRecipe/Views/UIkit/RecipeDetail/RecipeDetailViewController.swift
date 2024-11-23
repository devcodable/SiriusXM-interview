import UIKit

//TODO: - #5 Implement the Details screen using RecipeDetailViewModel

final class RecipeDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: RecipeDetailViewModelUIKit
    
    // MARK: - Initializer
    
    init(viewModel: RecipeDetailViewModelUIKit) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Helper for Loading Image
extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}


#Preview {
    RecipeDetailViewController(viewModel: .init(recipe: .preview))
}
