//
//  ChannelsService.swift
//  Test
//
//  Created by Adrian Pandelea on 04.06.2024.
//

import Foundation

struct ChannelsResponse: Codable {
    var record: [Channel]
}

protocol ChannelsServiceProtocol {
    func fetchChannels(completion: @escaping (Result<[Channel], Error>) -> Void)
}

class ChannelsService: ChannelsServiceProtocol {
    
    private var httpClient: HttpClientProtocol
    
    init(httpClient: HttpClientProtocol = HttpClient()) {
        self.httpClient = httpClient
    }
    
    func fetchChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {
        httpClient.fetch(endPoint: .getChannels, responseType: ChannelsResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.record))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
