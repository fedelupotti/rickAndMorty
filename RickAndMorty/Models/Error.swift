//
//  Error.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 25/04/24.
//

import Foundation

enum IOError: Error, Equatable {
    case conection
    case networkError(String)
}
