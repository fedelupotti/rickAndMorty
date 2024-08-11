//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Federico Lupotti on 24/04/24.
//

import XCTest
import Combine
@testable import RickAndMorty

// Naming structure: test_UnitOfWork_StateUnderTest_ExcpectedBehaviour
// Naming structure: test_[Struct/Class] _ [Variable/function] _ expected result

final class RickAndMortyTests: XCTestCase {
    private var sut: ViewModel!
    private var sutRepository: Repository!
    
    private lazy var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        sutRepository = Repository(apiService: MockAPIService())
        sut = ViewModel(repository: sutRepository)
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        sutRepository = nil
        
        try super.tearDownWithError()
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
    
    func test_ViewModel_onRefresh_isLoading() async {
        
        sut.onRefresh()
        XCTAssertEqual(sut.isLoading, true)
    }
    
    func test_ViewModel_getAllIdEpisodesForCharacter_return51Episodes() {
        //Given
        let character = Character.mock51EpisodesTest
        
        //When
        let idsEpisodes = sut.testGetAllIdEpisodesForCharacter(character)
        
        //Then
        XCTAssert(idsEpisodes.count == 51)
    }
    
    func test_getAllEpisodesForEpisodesId_take2Episodes() {
        //Given
        let episodesId = [1,2]
        let episodes = Episode.mock2EpisodesTest
        
        //When
        let episodesSelected = sut.testGetAllEpisodesForEpisodesId(episodesId: episodesId, episodes: episodes)
        
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
        sut.testAssingLocalEpisodesToCharacters(characters: characters, episodes: episodes)
        let charactesHaveNotEpisodes = sut.testAllCharactersWithoutEpisodesObject(characters)
        
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
//        let charactesHaveNotEpisodes = sut.testAllCharactersWithoutEpisodesObject(characters)
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
    
    func test_Repository_fetchAllCharacters_atLeastOneCharacterAfterFetch() async {
        sutRepository.fetchAllCharacters()
        
        let expectation = XCTestExpectation(description: "One Character")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            let characterOnInit = self?.sutRepository.characters ?? []
            XCTAssertTrue(!characterOnInit.isEmpty)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        
    }
    
    func test_Repository_fetchAllCharacters_FirstCharacterId() async {
        
        let expectation = XCTestExpectation(description: "Get one character")
        
        sutRepository.$characters
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { character in
                XCTAssertTrue(!character.isEmpty)
                XCTAssertEqual(character.first?.id, 1)
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        sutRepository.fetchAllCharacters()
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func test_Repository_fetchAllCharacters_WithoutError() async {
        let expectation = XCTestExpectation(description: "Get any error")
        
        sutRepository.$characters
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] characters in
                
                XCTAssertTrue(self?.sutRepository.error == nil)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sutRepository.fetchAllCharacters()
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func test_Repository_isLoading_ToastOrderFetchCharacters() async {
        
        let expectation = XCTestExpectation(description: "isLoading correct order")
        
        var isLoadingValuesCollected: [Bool] = []
        
        sutRepository.$isLoading
            .dropFirst()
            .prefix(2)
            .collect(2)
            .receive(on: DispatchQueue.main)
            .sink { values in
                isLoadingValuesCollected = values.map{( $0.unsafelyUnwrapped )}
                
                XCTAssertTrue(isLoadingValuesCollected.first == true)
                XCTAssertTrue(isLoadingValuesCollected.last == false)
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sutRepository.fetchAllCharacters()
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func test_Repository_isLoading_ToastOrderFetchEpisodes() async {
        
        let expectation = XCTestExpectation(description: "isLoading correct order")
        
        var isLoadingValuesCollected: [Bool] = []
        
        sutRepository.$isLoading
            .dropFirst()
            .prefix(2)
            .collect(2)
            .receive(on: DispatchQueue.main)
            .sink { values in
                isLoadingValuesCollected = values.map{( $0.publisher.output ?? false )}
                
                XCTAssertTrue(isLoadingValuesCollected.first == true)
                XCTAssertTrue(isLoadingValuesCollected.last == false)
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sutRepository.fetchAllEpisodes()
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func test_Repository_IOErrorConnection_FetchAllCharactersWithConnectionError() async {
        let expectation = XCTestExpectation(description: "Not connection error handling")
        
        let characterURLString = "\(Path.baseURL.rawValue + Path.character.rawValue)"
        let url = URL(string: characterURLString)!
        let connectionError = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        
        URLProtocolMock.errorURLs = [url: connectionError]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        
        sutRepository = Repository(apiService: APIService(session: session))
        sutRepository.fetchAllCharacters()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            XCTAssertEqual(self?.sutRepository.error, IOError.conection)
            XCTAssertTrue(self?.sutRepository.isLoading == false, "isLoading should be false at ending")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func test_Repository_IOErrorConnection_FetchAllEpisodesWithConnectionError() async {
        let expectation = XCTestExpectation(description: "Not conection error handling")
        
        let characterURLString = "\(Path.baseURL.rawValue + Path.episode.rawValue)"
        let url = URL(string: characterURLString)!
        let connectionError = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        
        URLProtocolMock.errorURLs = [url: connectionError]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        
        sutRepository = Repository(apiService: APIService(session: session))
        sutRepository.fetchAllEpisodes()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            XCTAssertEqual(self?.sutRepository.error, IOError.conection)
            XCTAssertTrue(self?.sutRepository.isLoading == false, "isLoading should be false at ending")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5)
    }
}
