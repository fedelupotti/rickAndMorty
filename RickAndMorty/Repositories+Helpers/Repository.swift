//
//  ServiceHelper.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 24/04/24.
//

import Combine
import Foundation

class Repository: ObservableObject, RepositoryProtocol {
    
    @Published internal var characters = [Character]()
    @Published internal var episodes = [Episode]()
    
    @Published internal var error: IOError?
    
    @Published internal var isLoading: Bool? = false
    
    var charactersPublisher: AnyPublisher<[Character], Never> { $characters.eraseToAnyPublisher() }
    var episodesPublisher: AnyPublisher<[Episode], Never> { $episodes.eraseToAnyPublisher() }
    
    var errorPublisher: AnyPublisher<IOError?, Never> { $error.eraseToAnyPublisher() }
    
    var isLoadingPublisher: AnyPublisher<Bool?, Never> { $isLoading.eraseToAnyPublisher() }
    
    private var apiService: APIServiceProtocol
    
    var didCallFetchAllCharacters: (() -> Void)?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchAllCharacters() {
        Task(priority: .high) {
            isLoading = true
            do {
                defer { didCallFetchAllCharacters?() }
                characters = try await apiService.fetchCharacters()
                error = nil
                print(characters)
            } catch IOError.conection {
                error = IOError.conection
            } catch {
                print(error)
            }
            isLoading = false
        }
    }
    
    func fetchAllEpisodes() {
        Task(priority: .high) {
            isLoading = true
            do {
                episodes = try await apiService.fetchEpisodes()
                print(episodes)
            }
            catch {
                print(error)
            }
            isLoading = false
        }
    }
}
