
import Foundation

struct Recipe: Identifiable, Codable {
    let id: String
    let publisher: String
    let title: String
    let sourceURL: URL
    let imageURL: URL
    let socialRank: Double
    let publisherURL: URL
    let ingredients: [String]?
    
    enum CodingKeys: String, CodingKey {
        case publisher
        case title
        case sourceURL = "source_url"
        case id = "recipe_id"
        case imageURL = "image_url"
        case socialRank = "social_rank"
        case publisherURL = "publisher_url"
        case ingredients
    }
}

struct SearchResponse: Codable {
    let count: Int
    let recipes: [Recipe]
}

struct DetailRecipeResponse: Codable {
    let recipe: Recipe
}
