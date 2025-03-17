//
//  RecipeListView.swift
//  FetchMobileHomeProject
//
//  Created by Irina Marmyl on 3/15/25.
//

import SwiftUI

struct RecipeListView: View {
    @State private var recipes: [Recipe] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                } else if recipes.isEmpty {
                    Text("No recipes found")
                        .padding()
                } else {
                    List(recipes) { recipe in
                        HStack {
                            if let imageUrl = recipe.photoUrlSmall, let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 80)
                                    case.failure:
                                        Image(systemName: "exclamationmark.triangle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 80)
                                        @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(recipe.title)
                                    .font(.headline)
                                Text(recipe.cuisine)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .navigationTitle("Recipes")
                }
            }
            .onAppear {
                loadRecipes()
            }
        }
    }
    
    private func loadRecipes() {
        Task {
            do {
                isLoading = true
                let featchedRecipes = try await RecipeService.shared.fetchRecipes()
                recipes = featchedRecipes
                isLoading = false
            } catch {
                errorMessage = "Failed to load recipes. Please try again!"
                isLoading = false
            }
        }
    }
    
    struct RecipeListView_Previews: PreviewProvider {
        static var previews: some View {
            RecipeListView()
        }
    }
}
