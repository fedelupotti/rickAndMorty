//
//  ViewModel.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 22/04/24.
//

import Combine
import Foundation


class ViewModel: ObservableObject {
    
    //MARK: Variables
    @Published private(set) var characters = [Character]()
    
    private var episodes = [Episode]()
    
    private var serviceHelper: ServiceHelper
    
    private lazy var cancellables = Set<AnyCancellable>()
    
    init(serviceHelper: ServiceHelper) {
        self.serviceHelper = serviceHelper
        
        setObservers()
        
        fetchAllCharacters()
        fetchAllEpisodes()
    }
    
    //MARK: Public func
    func onRefresh() {
        fetchAllCharacters()
        fetchAllEpisodes()
    }
    
    //MARK: Private func
    private func assingLocalEpisodesToCharacters() {
        var characters = characters
        
        for (index, character) in characters.enumerated() {
            let episodesId = getAllIdEpisodesForCharacter(character)
            let episodes = getAllEpisodesForEpisodesId(episodesId: episodesId)
            
            characters[index].episodesObject = episodes            
        }
        self.characters = characters
    }

    private func setObservers() {
        serviceHelper.$characters
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] characters in
                guard let self else { return  }
                
                self.characters = characters
                if self.charactersWithoutEpisodes(characters) {
                    self.assingLocalEpisodesToCharacters()
                }
            })
            .store(in: &cancellables)
        
        serviceHelper.$episodes
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] episodes in
                self?.episodes = episodes
                self?.assingLocalEpisodesToCharacters()
            })
            .store(in: &cancellables)
        
    }
    
    private func charactersWithoutEpisodes(_ characters: [Character]) -> Bool {
        return characters.allSatisfy({ $0.episodesObject == nil })
    }
    
    private func fetchAllCharacters() {
        serviceHelper.fetchAllCharacters()
    }
    
    private func fetchAllEpisodes() {
        serviceHelper.fetchAllEpisodes()
    }
    
    private func getAllEpisodesForEpisodesId(episodesId: [Int]) -> [Episode] {
        var episodes = [Episode]()
        
        for id in episodesId {
            guard let episode = self.episodes.first(where: { $0.id == id }) else { continue }
            episodes.append(episode)
        }
        
        return episodes
    }
    
    private func getAllIdEpisodesForCharacter(_ character: Character) -> [Int] {
        guard let episodes = character.episode else { return [] }
        var idEpisodes: [Int] = []
        
        for urlString in episodes {
            let component = urlString.components(separatedBy: "/")
            guard let lastComponent = component.last, let intEpisode = Int(lastComponent) else { continue }
            idEpisodes.append(intEpisode)
        }
        
        return idEpisodes
    }
}
