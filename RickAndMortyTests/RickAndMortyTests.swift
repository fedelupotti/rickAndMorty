//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Federico Lupotti on 24/04/24.
//

import XCTest
@testable import RickAndMorty

// Naming structure: test_UnitOfWork_StateUnderTest_ExcpectedBehaviour
// Naming structure: test_[Struct/Class] _ [Variable/function] _ expected result

final class RickAndMortyTests: XCTestCase {
    private var sut: ViewModel!
    private var sutRepository: Repository!

    override func setUpWithError() throws {
        sut = ViewModel(repository: Repository(apiService: MockAPIService()))
        sutRepository = Repository(apiService: MockAPIService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ViewModel_characterVariable_isCharacterType() {
        //Given
        let characterVariable = sut.characters
        
        //When
        //Init already done
        
        //Then
        XCTAssertTrue((characterVariable is [Character]))
    }
    
    func test_ViewModel_onRefresh_notExistOnInit() {
        //Given
        
        //When
        //Init already done

        
        //Then
        XCTAssertTrue(sut.didCallFunction == nil)
    }
    
    func test_ViewModel_onRefresh_functionCalled() {
        //Given
        
        //When
        let exp = expectation(description: #function)
        sut.didCallFunction = { exp.fulfill() }
        sut.onRefresh()
        waitForExpectations(timeout: 1)
        
        //Then
        XCTAssertTrue(sut.didCallFunction != nil)
    }
    
    func test_ViewModel_getAllIdEpisodesForCharacter_return51Episodes() {
        //Given
        let character = Character(id: 1, episode: ["https://rickandmortyapi.com/api/episode/1",
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
        
        //When
        let idsEpisodes = sut.getAllIdEpisodesForCharacter(character)
        
        //Then
        XCTAssert(idsEpisodes.count == 51)
    }
    
    func test_getAllEpisodesForEpisodesId_take2EpisodesAmount() {
        //Given
        let episodesId = [1,2]
        let episodes = [
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
        
        //When
        let episodesSelected = sut.getAllEpisodesForEpisodesId(episodesId: episodesId, episodes: episodes)
        
        //Then
        XCTAssertTrue(episodesSelected.count == 2)
    }
    
    func test_ViewModel_charactersWithoutEpisodes_True() {
        //Given
        let characters = [Character(id: 1, episode: ["https://rickandmortyapi.com/api/episode/1",""]),
                          Character(id: 2, episode: [])
        ]
        let episodes: [Episode] = []
        
        //When
        sut.assingLocalEpisodesToCharacters(characters: characters, episodes: episodes)
        let charactesHaveNotEpisodes = sut.allCharactersWithoutEpisodesObject(characters)
        
        //Then
        
        XCTAssertTrue(charactesHaveNotEpisodes)
    }
//    
//    func test_ViewModel_charactersWitoutEpisodes_False() {
//        //Given
//        let characters = [Character(id: 1, episode: ["https://rickandmortyapi.com/api/episode/1","https://rickandmortyapi.com/api/episode/2"]),
//                          Character(id: 2, episode: ["https://rickandmortyapi.com/api/episode/1"])
//        ]
//        let episodes = [Episode(id: 1, name: "Some episode!"),
//                        Episode(id: 2)
//        ]
//        
//        //When
//        sut.assingLocalEpisodesToCharacters(characters: characters, episodes: episodes)
//        let charactesHaveNotEpisodes = sut.allCharactersWithoutEpisodesObject(characters)
//        
//        //Then
//        XCTAssertFalse(charactesHaveNotEpisodes)
//    }
    
    func test_Repository_Characters_isEmptyOnInit() {
        //Given
        
        //When
        let characterOnInit = sutRepository.characters
        
        //Then
        XCTAssertTrue(characterOnInit.isEmpty)
    }
    
    func test_Repository_fetchAllCharacters_atLeastOneCharacterAfterFetch() {
        let exp = expectation(description: #function)
        
        //Given
        sutRepository.didCallFetchAllCharacters = { exp.fulfill() }
        sutRepository.fetchAllCharacters()
        waitForExpectations(timeout: 1)
        
        //When
        let characterOnInit = sutRepository.characters
        
        //Then
        XCTAssertTrue(!characterOnInit.isEmpty)
    }
}
