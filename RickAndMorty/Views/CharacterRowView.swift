//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 29/04/24.
//

import SwiftUI

struct CharacterRowView: View {
    
    var character: Character
    
    var body: some View {
        HStack(alignment: .top) {
            
            if let image = character.image, let imageURL = URL(string: image) {
                AsyncImage(url: imageURL) { imagen in
                    
                    imagen.resizable()
                    
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                
            } else {
                Image(systemName: "person.slash")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text(character.name ?? "")
                    .font(.headline)
                
                Text(character.species ?? "")
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    CharacterRowView(character: Character.mock.first!)
}
