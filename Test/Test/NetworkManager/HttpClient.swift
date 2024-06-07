//
//  HttpClient.swift
//  Test
//
//  Created by Adrian Pandelea on 04.06.2024.
//

import Foundation


enum Endpoint {
    case getTargetSpecifics
    case getChannels
    
    static var baseURLString = "https://api.jsonbin.io/v3/b/"
    
    var urlString: String {
        switch self {
        case .getTargetSpecifics:
            Self.baseURLString + "665e37aeacd3cb34a8524272"
        case .getChannels:
            Self.baseURLString + "665e3ee9ad19ca34f873ce3f"
        }
    }
    
    var method: String {
        "GET"
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case noResponse
    case invalidData
}

protocol HttpClientProtocol {
    func fetch<T: Decodable>(endPoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class HttpClient: HttpClientProtocol {
    
    let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T: Decodable>(endPoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: endPoint.urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method

        let task = urlSession.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response else {
                completion(.failure(NetworkError.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }

}
