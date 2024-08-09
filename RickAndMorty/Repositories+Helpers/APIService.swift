//
//  APIService.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 22/04/24.
//

import Foundation

enum Path: String {
    case baseURL = "https://rickandmortyapi.com/api"
    case character = "/character"
    case episode = "/episode"
    case location = "/location"
}

class APIService: APIServiceProtocol {
    
    private let session: URLSession
    
    internal lazy var baseURL = Path.baseURL.rawValue
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchCharacters() async throws -> [Character] {
        let characterURLString = "\(baseURL + Path.character.rawValue)"
        
        guard let characterURL = URL(string: characterURLString) else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        do {
            let (data, _) = try await session.data(from: characterURL)
            let decoder = JSONDecoder()
            let characterResponse = try decoder.decode(CharacterResponse.self, from: data)
            
            return characterResponse.results ?? []
            
        } catch let error as NSError {
            if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                print(error.localizedDescription)
                throw IOError.conection
            } else {
                throw IOError.networkError("Network error undefined")
            }
        }
    }
    
    func fetchEpisodes() async throws -> [Episode] {
        let episodeURLString = "\(baseURL + Path.episode.rawValue)"
        
        guard let episodeURL = URL(string: episodeURLString) else {
            throw NSError()
        }
        do {
            let (data, _) = try await session.data(from: episodeURL)
            let decoder = JSONDecoder()
            let episodeResponse = try decoder.decode(EpisodeResponse.self, from: data)
            
            return episodeResponse.results ?? []
        } catch let error as NSError {
            if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                print(error.localizedDescription)
                throw IOError.conection
            } else {
                throw IOError.networkError("Network error undefined")
            }
        }
       
    }
}
