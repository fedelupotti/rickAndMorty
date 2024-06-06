//
//  MockAPIService.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 24/04/24.
//

import Foundation

class MockAPIService: APIServiceProtocol {
    var baseURL = Path.baseURL.rawValue
    
    func fetchCharacters() throws -> [Character] {
        //Mock also could be Injected (for Testing reasons)
        let mockData = """
                   {
                     "info": {
                       "count": 826,
                       "pages": 42,
                       "next": "https://rickandmortyapi.com/api/character?page=2",
                       "prev": null
                     },
                     "results": [
                       {
                         "id": 1,
                         "name": "Rick Sanchez",
                         "status": "Alive",
                         "species": "Human",
                         "type": "",
                         "gender": "Male",
                         "origin": {
                           "name": "Earth (C-137)",
                           "url": "https://rickandmortyapi.com/api/location/1"
                         },
                         "location": {
                           "name": "Citadel of Ricks",
                           "url": "https://rickandmortyapi.com/api/location/3"
                         },
                         "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                         "episode": [
                           "https://rickandmortyapi.com/api/episode/1",
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
                         ],
                         "url": "https://rickandmortyapi.com/api/character/1",
                         "created": "2017-11-04T18:48:46.250Z"
                       }
                   ]}
                   """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let characterResponse = try decoder.decode(CharacterResponse.self, from: mockData)
        
        return characterResponse.results ?? []
    }
    
    func fetchEpisodes() throws -> [Episode] {
        let mockData = """
{
  "info": {
    "count": 51,
    "pages": 3,
    "next": "https://rickandmortyapi.com/api/episode?page=2",
    "prev": null
  },
  "results": [
    {
      "id": 1,
      "name": "Pilot",
      "air_date": "December 2, 2013",
      "episode": "S01E01",
      "characters": [
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
      ],
      "url": "https://rickandmortyapi.com/api/episode/1",
      "created": "2017-11-10T12:56:33.798Z"
    }
]}
""".data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let episodeResponse = try decoder.decode(EpisodeResponse.self, from: mockData)
        
        return episodeResponse.results ?? []
    }
}
