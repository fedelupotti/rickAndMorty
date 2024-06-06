//
//  RepositoryProtocol.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 24/04/24.
//

import Combine
import Foundation

protocol RepositoryProtocol {
    var characters: [Character] { get }
    var episodes: [Episode] { get }
    
    var error: IOError? { get }
    
    var isLoading: Bool? { get }
    
    var charactersPublisher: AnyPublisher<[Character], Never> { get }
    var episodesPublisher: AnyPublisher<[Episode], Never> { get }
    
    var errorPublisher: AnyPublisher<IOError?, Never> { get }
    
    var isLoadingPublisher: AnyPublisher<Bool? ,Never> { get }
    
    func fetchAllCharacters()
    func fetchAllEpisodes()
}
