//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 22/04/24.
//

import SwiftUI

struct CharactersListView: View {
    
    @StateObject var viewModel = ViewModel()
    
//    @StateObject var networkMonitor = NetworkMonitor()
    
    @State var isLoading = true
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.connectionAvaiable {
                    List {
                        ForEach(viewModel.characters) { character in
                            
                            NavigationLink {
                                CharacterDetailView(character: character)
                            } label: {
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
                        
                        
                    }
                    .refreshable {
                        viewModel.updateNetworkStatus()
                        viewModel.onRefresh()
                    }
                    
                } else {
                    ConnectionFailsView {
                        viewModel.onRefresh()
                    }
                }
            }
//            .overlay(loadingOverlay)
            
            .listStyle(.plain)
            .navigationTitle("Rick & Morty")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
    
//    @ViewBuilder private var loadingOverlay: some View {
//        if isLoading {
//            ZStack {
//                ConnectionFailsView() {
//                    isLoading = false
//                }
//                .opacity(1)
//                
//            }
//        }
//    }
}

#Preview {
    CharactersListView()
}
