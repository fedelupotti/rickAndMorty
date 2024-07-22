//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 23/04/24.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ScrollView {
                if let image = character.image, let imageURL = URL(string: image) {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                }
            
            VStack(alignment: .leading) {
                Text(character.name ?? "")
                    .font(.title.bold())
                    .padding([.top, .bottom])
                
                Text("Episodes where appear:")
                    .font(.headline.bold())
                    .foregroundStyle(Color.secondary)
            
                ForEach(character.episodesObject ?? []) { episode in
                    VStack(alignment: .leading) {
                        Text("• \(episode.name ?? "")")
                            .font(.headline)
                            .foregroundStyle(Color.secondary)
                            .padding(.top, 5)
                    }
                }
            }
            .navigationTitle("Character")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CharacterDetailView(character: Character.mock.first!)
}
