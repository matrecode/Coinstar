//
//  NetworkClient.swift
//  Coinstar
//
//  Created by Akshay Matre on 12/08/26.
//

import Foundation

protocol NetworkClient {
    func request<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
    
    func post<Body: Encodable, Response: Decodable>(_ type: Response.Type, to url: URL, body: Body) async throws -> Response
    
}

class URLSessionNetworkClient: NetworkClient {
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ){
        self.urlSession = session
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func request<T>(_ type: T.Type, from url: URL) async throws -> T where T : Decodable {
        let (data, response) = try await urlSession.data(from: url)
        
        try validate(response)
        return try decoder.decode(T.self, from: data)
    }
    
    func post<Body: Encodable, Response: Decodable>(_ type: Response.Type, to url: URL, body: Body) async throws -> Response {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(body)
        
        let (data, response) = try await urlSession.data(for: request)
        try validate(response)
        return try decoder.decode(Response.self, from: data)
    }
    
    private func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpStatus(httpResponse.statusCode)
        }
    }
    
}
