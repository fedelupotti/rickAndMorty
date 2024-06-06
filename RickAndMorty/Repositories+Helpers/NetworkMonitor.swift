//
//  NetworkMonitor.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 25/04/24.
//

import Foundation
import Network


class NetworkMonitor: ObservableObject {
    
    @Published private(set) var networkIsConnected = true
    
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")

    init() {
        updateNetworkStatus()
    }
    
    func updateNetworkStatus() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
                self?.networkIsConnected = path.status == .satisfied
            }
        networkMonitor.start(queue: workerQueue)
    }
}
