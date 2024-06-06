//
//  APIServiceProtocol.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 25/04/24.
//

import Foundation

protocol APIServiceProtocol {
    var baseURL: String { get }
    
    func fetchCharacters() async throws -> [Character]
    func fetchEpisodes() async throws -> [Episode]
}
