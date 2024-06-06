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
    
    @Published private(set) var filterCharacters = [Character]()
    
    @Published private(set) var error: IOError?
    
    @Published private(set) var connectionAvaiable = false
    
    @Published var searchableText = ""
    
    @Published private(set) var isLoading = true 
    
    var serachableCharacters: [Character] {
        if searchableText.isEmpty { return characters }
        return characters.filter{( $0.name?.lowercased().contains(searchableText.lowercased()) ?? false )}
    }
    
    private var episodes = [Episode]()
    
    private var repository: RepositoryProtocol
    
    private var networkMonitor = NetworkMonitor()
    
    private lazy var cancellables = Set<AnyCancellable>()
        
    var didCallFunction: (() -> Void)?
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
        
        setObservers()
        
        fetchAllCharacters()
        fetchAllEpisodes()
    }
    
    //MARK: Public func
    func onRefresh() {
        defer { didCallFunction?() }
        
        if !connectionAvaiable { return }
        fetchAllCharacters()
        fetchAllEpisodes()
    }
    
    //MARK: Private func
    private func setObservers() {
        repository.isLoadingPublisher
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isLoading in
                self?.isLoading = isLoading ?? false
            })
            .store(in: &cancellables)
        
        repository.charactersPublisher
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] characters in
                guard let self else { return  }
                
                self.characters = characters
                if self.allCharactersWithoutEpisodesObject(characters) {
                    self.assingLocalEpisodesToCharacters(characters: characters, episodes: self.episodes)
                }
            })
            .store(in: &cancellables)
        
        repository.episodesPublisher
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] episodes in
                guard let self else { return }
                
                self.episodes = episodes
                self.assingLocalEpisodesToCharacters(characters: self.characters, episodes: episodes)
            })
            .store(in: &cancellables)
        
        repository.errorPublisher
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                self?.error = error
            })
            .store(in: &cancellables)
        
        networkMonitor.$networkIsConnected
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isConnected in
                self?.connectionAvaiable = isConnected
            })
            .store(in: &cancellables)
    }
    
    func updateNetworkStatus() {
        networkMonitor.updateNetworkStatus()
    }
    
    func assingLocalEpisodesToCharacters(characters: [Character], episodes: [Episode]) {
        var characters = characters
        
        for (index, character) in characters.enumerated() {
            let episodesId = getAllIdEpisodesForCharacter(character)
            let episodes = getAllEpisodesForEpisodesId(episodesId: episodesId, episodes: episodes)
            
            characters[index].episodesObject = episodes
        }
        self.characters = characters
    }
    
    func allCharactersWithoutEpisodesObject(_ characters: [Character]) -> Bool {
        return characters.allSatisfy({ $0.episodesObject == nil })
    }
    
    private func fetchAllCharacters() {
        repository.fetchAllCharacters()
    }
    
    private func fetchAllEpisodes() {
        repository.fetchAllEpisodes()
    }
    
    func getAllEpisodesForEpisodesId(episodesId: [Int], episodes: [Episode]) -> [Episode] {
        var characterEpisodes = [Episode]()
        
        for id in episodesId {
            guard let episode = episodes.first(where: { $0.id == id }) else { continue }
            characterEpisodes.append(episode)
        }
        
        return characterEpisodes
    }
    
    func getAllIdEpisodesForCharacter(_ character: Character) -> [Int] {
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
