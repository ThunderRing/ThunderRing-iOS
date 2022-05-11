//
//  TotalGroupData.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/12.
//

import Foundation

// MARK: - TotalGroupResponse

struct TotalGroupResponse: Codable {
    let natureGroupData, hobbyGroupData, foodGroupData, outdoorGroupData: [PublicGroupData]

    enum CodingKeys: String, CodingKey {
        case natureGroupData = "NatureGroupData"
        case hobbyGroupData = "HobbyGroupData"
        case foodGroupData = "FoodGroupData"
        case outdoorGroupData = "OutdoorGroupData"
    }
}
