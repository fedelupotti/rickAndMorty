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
    
    static let mock51EpisodesTest = Character(id: 1, episode: ["https://rickandmortyapi.com/api/episode/1",
                                          "https://rickandmortyapi.com/api/episode/2",
                                          "https://rickandmortyapi.com/api/episode/3",
                                          "https://rickandmortyapi.com/api/episode/4",
                                          "https://rickandmortyapi.com/api/episode/5",
                                          "https://rickandmortyapi.com/api/episode/6",
                                          "https://rickandmortyapi.com/api/episode/7",
                                          "https://rickandmortyapi.com/api/episode/8",
                                          "https://rickandmortyapi.com/api/episode/9",
                                          "https://rickandmortyapi.com/api/episode/10",
                                          "https://rickandmortyapi.com/api/episode/11",
                                          "https://rickandmortyapi.com/api/episode/12",
                                          "https://rickandmortyapi.com/api/episode/13",
                                          "https://rickandmortyapi.com/api/episode/14",
                                          "https://rickandmortyapi.com/api/episode/15",
                                          "https://rickandmortyapi.com/api/episode/16",
                                          "https://rickandmortyapi.com/api/episode/17",
                                          "https://rickandmortyapi.com/api/episode/18",
                                          "https://rickandmortyapi.com/api/episode/19",
                                          "https://rickandmortyapi.com/api/episode/20",
                                          "https://rickandmortyapi.com/api/episode/21",
                                          "https://rickandmortyapi.com/api/episode/22",
                                          "https://rickandmortyapi.com/api/episode/23",
                                          "https://rickandmortyapi.com/api/episode/24",
                                          "https://rickandmortyapi.com/api/episode/25",
                                          "https://rickandmortyapi.com/api/episode/26",
                                          "https://rickandmortyapi.com/api/episode/27",
                                          "https://rickandmortyapi.com/api/episode/28",
                                          "https://rickandmortyapi.com/api/episode/29",
                                          "https://rickandmortyapi.com/api/episode/30",
                                          "https://rickandmortyapi.com/api/episode/31",
                                          "https://rickandmortyapi.com/api/episode/32",
                                          "https://rickandmortyapi.com/api/episode/33",
                                          "https://rickandmortyapi.com/api/episode/34",
                                          "https://rickandmortyapi.com/api/episode/35",
                                          "https://rickandmortyapi.com/api/episode/36",
                                          "https://rickandmortyapi.com/api/episode/37",
                                          "https://rickandmortyapi.com/api/episode/38",
                                          "https://rickandmortyapi.com/api/episode/39",
                                          "https://rickandmortyapi.com/api/episode/40",
                                          "https://rickandmortyapi.com/api/episode/41",
                                          "https://rickandmortyapi.com/api/episode/42",
                                          "https://rickandmortyapi.com/api/episode/43",
                                          "https://rickandmortyapi.com/api/episode/44",
                                          "https://rickandmortyapi.com/api/episode/45",
                                          "https://rickandmortyapi.com/api/episode/46",
                                          "https://rickandmortyapi.com/api/episode/47",
                                          "https://rickandmortyapi.com/api/episode/48",
                                          "https://rickandmortyapi.com/api/episode/49",
                                          "https://rickandmortyapi.com/api/episode/50",
                                          "https://rickandmortyapi.com/api/episode/51"
])
}

