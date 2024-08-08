//
//  URLProtocolMock.swift
//  RickAndMorty
//
//  Created by Federico Lupotti on 08/08/24.
//

import Foundation

class URLProtocolMock: URLProtocol {
    // Este diccionario asigna URLs a datos de prueba
    static var testURLs = [URL?: Data]()
    
    // Este diccionario asigna URLs a errores de prueba
    static var errorURLs = [URL?: NSError]()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // Si tenemos una URL válida...
        if let url = request.url {
            // ...y si tenemos un error para esa URL...
            if let error = URLProtocolMock.errorURLs[url] {
                // ...devuelve el error.
                self.client?.urlProtocol(self, didFailWithError: error)
            } else if let data = URLProtocolMock.testURLs[url] {
                // ...de lo contrario, devuelve los datos de prueba.
                self.client?.urlProtocol(self, didLoad: data)
            }
        }
        
        // Marca que hemos terminado
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
