//
//  Channel.swift
//  Test
//
//  Created by Adrian Pandelea on 28.05.2024.
//

import Foundation

struct Channel: Codable {
    let id: Int
    let name: String
    let campaigns: [Campaign]
}
