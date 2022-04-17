//
//  PrivageGroupDetailResponse.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/18.
//

import Foundation

// MARK: - PrivateGroupDetailResponse

struct PrivateGroupDetailResponse: Codable {
    let groupDetailData: [PrivateGroupDetailData]
}

// MARK: - PrivateGroupDetailData

struct PrivateGroupDetailData: Codable {
    let groupName, groupDescription: String
    let groupMembers: [String]
    let history: [History]
}

// MARK: - History

struct History: Codable {
    let date, lightningName: String
    let memberCount: Int
    let location: String
}

