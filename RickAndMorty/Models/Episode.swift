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
