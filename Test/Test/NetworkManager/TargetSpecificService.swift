//
//  TargetSpecificService.swift
//  Test
//
//  Created by Adrian Pandelea on 03.06.2024.
//

import Foundation


struct TargetSpecificResponse: Codable {
    var record: [TargetSpecific]
}

protocol TargetSpecificServiceProtocol {
    func fetchTargetSpecifics(completion: @escaping (Result<[TargetSpecific], Error>) -> Void)
}

class TargetSpecificService: TargetSpecificServiceProtocol {
    
    private var httpClient: HttpClientProtocol
    
    init(httpClient: HttpClientProtocol = HttpClient()) {
        self.httpClient = httpClient
    }
    
    func fetchTargetSpecifics(completion: @escaping (Result<[TargetSpecific], Error>) -> Void) {
        httpClient.fetch(endPoint: .getTargetSpecifics, responseType: TargetSpecificResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.record))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
