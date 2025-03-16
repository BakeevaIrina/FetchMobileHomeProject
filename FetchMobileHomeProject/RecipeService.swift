//
//  RecipeService.swift
//  FetchMobileHomeProject
//
//  Created by Irina Marmyl on 3/15/25.
//

import Foundation

class RecipeService {
    static let shared = RecipeService()
    
    private let apiURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: apiURL) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponce = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return decodedResponce.recipes
    }
}
