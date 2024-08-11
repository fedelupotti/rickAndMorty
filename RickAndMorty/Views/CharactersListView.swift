//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 22/04/24.
//

import SwiftUI

struct CharactersListView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.connectionAvaiable {
                    List {
                        ForEach(viewModel.serachableCharacters) { character in
                            
                            NavigationLink {
                                CharacterDetailView(character: character)
                            } label: {
                               CharacterRowView(character: character)
                            }
                        }
                    }
                    .refreshable {
                        viewModel.onRefresh()
                    }
                    
                } else {
                    ConnectionFailsView {
                        //Here we are not actualy refreshing, but we give to the user the idea that he, she is doing it, for UX purpose
                        viewModel.onRefresh()
                    }
                }
            }
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                            .background(Color.white.opacity(0))
                    }
                }
            )
            
            .listStyle(.plain)
            .navigationTitle("Rick & Morty")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .searchable(text: $viewModel.searchableText)
        .autocorrectionDisabled()
    }
}

#Preview {
    CharactersListView()
}
