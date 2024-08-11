//
//  Episode.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 25/04/24.
//

import Foundation

struct EpisodeResponse: Codable {
    var info: Info?
    var results: [Episode]?
}

struct Episode: Codable, Identifiable {
    let id: Int?
    var name: String?
    var air_date: String?
    var episode: String?
    var characters: [String]?
    var url: String?
    var created: String?
}

extension Episode {
    static let mock2EpisodesTest = [
        Episode(id: 1, name: "Pilot", air_date: "December 2, 2013", episode: "S01E01", characters: [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            "https://rickandmortyapi.com/api/character/35",
            "https://rickandmortyapi.com/api/character/38",
            "https://rickandmortyapi.com/api/character/62",
            "https://rickandmortyapi.com/api/character/92",
            "https://rickandmortyapi.com/api/character/127",
            "https://rickandmortyapi.com/api/character/144",
            "https://rickandmortyapi.com/api/character/158",
            "https://rickandmortyapi.com/api/character/175",
            "https://rickandmortyapi.com/api/character/179",
            "https://rickandmortyapi.com/api/character/181",
            "https://rickandmortyapi.com/api/character/239",
            "https://rickandmortyapi.com/api/character/249",
            "https://rickandmortyapi.com/api/character/271",
            "https://rickandmortyapi.com/api/character/338",
            "https://rickandmortyapi.com/api/character/394",
            "https://rickandmortyapi.com/api/character/395",
            "https://rickandmortyapi.com/api/character/435"
        ]), Episode(id: 2, name: "Lawnmower Dog", air_date: "December 9, 2013", episode: "" , characters: ["https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            "https://rickandmortyapi.com/api/character/38",
            "https://rickandmortyapi.com/api/character/46",
            "https://rickandmortyapi.com/api/character/63",
            "https://rickandmortyapi.com/api/character/80",
            "https://rickandmortyapi.com/api/character/175",
            "https://rickandmortyapi.com/api/character/221",
            "https://rickandmortyapi.com/api/character/239",
            "https://rickandmortyapi.com/api/character/246",
            "https://rickandmortyapi.com/api/character/304",
            "https://rickandmortyapi.com/api/character/305",
            "https://rickandmortyapi.com/api/character/306",
            "https://rickandmortyapi.com/api/character/329",
            "https://rickandmortyapi.com/api/character/338",
            "https://rickandmortyapi.com/api/character/396",
            "https://rickandmortyapi.com/api/character/397",
            "https://rickandmortyapi.com/api/character/398",
            "https://rickandmortyapi.com/api/character/405"
        ])
    ]
}
