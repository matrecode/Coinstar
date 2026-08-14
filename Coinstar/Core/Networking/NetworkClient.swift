//
//  NetworkClient.swift
//  Coinstar
//
//  Created by Akshay Matre on 12/08/26.
//

import Foundation

protocol NetworkClient {
    func request<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
}

class URLSessionNetworkClient: NetworkClient {
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()){
        self.urlSession = session
        self.decoder = decoder
    }
    func request<T>(_ type: T.Type, from url: URL) async throws -> T where T : Decodable {
        let (data, response) = try await urlSession.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpStatus(httpResponse.statusCode)
        }
        
        return try decoder.decode(T.self, from: data)
    }

    
}
