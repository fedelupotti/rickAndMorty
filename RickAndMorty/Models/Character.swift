//
//  Character.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 22/04/24.
//

import Foundation

struct Origin: Codable {
    var name: String?
    var url: String?
}

struct Location: Codable {
    var name: String?
    var url: String?
}

struct Character: Codable, Identifiable {
    let id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: Origin?
    var location: Location?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
    
    var episodesObject: [Episode]?
}

struct Info: Codable {
    //Not needed
}

struct CharacterResponse: Codable {
    var info: Info?
    var results: [Character]?
}

extension Character {
    static let mock = [ Character(id: 2, name: "Morty Smith", status: "Human", species: nil, type: nil, gender: nil, origin: nil, location: nil, image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", episode: nil, url: nil, created: nil)
    ]
}

