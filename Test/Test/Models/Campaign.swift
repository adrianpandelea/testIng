//
//  Campaign.swift
//  Test
//
//  Created by Adrian Pandelea on 28.05.2024.
//

import Foundation

struct Campaign: Codable, Equatable {
    let id: Int
    let monthlyFee: Double
    let details: String
    let currency: String
}
