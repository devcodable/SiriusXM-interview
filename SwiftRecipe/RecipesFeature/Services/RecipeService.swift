
import Foundation

protocol RecipeServiceInterface {
    func searchRecipe(query: String) async throws(APIError) -> SearchResponse
    func fetchRecipeDetails(id: String) async throws(APIError) -> Recipe
}

struct RecipeService: RecipeServiceInterface {
    struct RecipesAPI {
        let searchURL: URL
        let detailsURL: URL
        
        init?(baseURL: String = "https://forkify-api.herokuapp.com") {
            guard let searchURL = URL(string: "\(baseURL)/api/search"),
                  let detailsURL = URL(string: "\(baseURL)/api/get") else {
                return nil
            }
            self.searchURL = searchURL
            self.detailsURL = detailsURL
        }
    }
    
    private let api: RecipesAPI
    
    init(api: RecipesAPI? = RecipesAPI()) {
        guard let api else {
            fatalError("Invalid API")
        }
        self.api = api
    }
    
    func searchRecipe(query: String) async throws(APIError) -> SearchResponse {
        var request = URLRequest(url: api.searchURL)
        request.url?.append(queryItems: [
            URLQueryItem(name: "q", value: query)
        ])
        
        let response: SearchResponse = try await makeNetworkCall(request: request)
        return response
    }

    func fetchRecipeDetails(id: String) async throws(APIError) -> Recipe {
        var request = URLRequest(url: api.detailsURL)
        request.url?.append(queryItems: [
            URLQueryItem(name: "rId", value: "\(id)")
        ])
        
        let response: DetailRecipeResponse = try await makeNetworkCall(request: request)
        return response.recipe
    }
    
    private func makeNetworkCall<T: Decodable>(request: URLRequest) async throws(APIError) -> T {
        do {
            let (data, respose) = try await URLSession.shared.data(for: request)
            guard let status = (respose as? HTTPURLResponse)?.statusCode else {
                throw APIError.invalidStatus
            }
            
            if (200...399).contains(status) {
                return try JSONDecoder().decode(T.self, from: data)
            } else if (400...499).contains(status)  {
                throw APIError.badRequest(status)
            } else if (500...599).contains(status) {
                throw APIError.serviceError
            } else {
                throw APIError.unknownError
            }
        } catch let apiError as APIError {
            throw apiError
        } catch let networkError as URLError {
            throw APIError.networkError(networkError)
        } catch let decoderError as DecodingError {
            throw APIError.unableToDecodeResponse(decoderError.localizedDescription)
        } catch {
            throw APIError.unknownError
        }
    }
}


enum APIError: Error {
    case badRequest(Int)
    case invalidStatus
    case networkError(URLError)
    case serviceError
    case unableToDecodeResponse(String)
    case unknownError
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest(let int):
            "Bad request: \(int)"
        case .invalidStatus:
            "Invalid status"
        case .networkError(let uRLError):
            "Network error: \(uRLError)"
        case .serviceError:
            "Service error"
        case .unableToDecodeResponse(let string):
            "Unable to decode response: \(string)"
        case .unknownError:
            "Unknown error"
        }
    }
}
