//
//  TargetSpecific.swift
//  Test
//
//  Created by Adrian Pandelea on 27.05.2024.
//

import Foundation

struct TargetSpecific: Codable {
    let id: Int
    let name: String
    let availableChannels: Set<Int>
}
