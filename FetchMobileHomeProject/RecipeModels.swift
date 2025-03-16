//
//  RecipeModels.swift
//  FetchMobileHomeProject
//
//  Created by Irina Marmyl on 3/15/25.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: String
    let title: String
    let cuisine: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourseUrl: String?
    let youtubeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case cuisine
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourseUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}
