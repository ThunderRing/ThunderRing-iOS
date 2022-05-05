//
//  LightningResponse.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/05.
//

import Foundation

// MARK: - LightningResponse

struct LightningResponse: Codable {
    let lightningData: [LightningData]
}

// MARK: - LightningData

struct LightningData: Codable {
    let name: String
    let maxMemberCount: Int
    let location, date, time: String
}
