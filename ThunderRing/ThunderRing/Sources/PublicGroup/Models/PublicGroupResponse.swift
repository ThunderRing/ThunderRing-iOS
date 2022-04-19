//
//  PublicGroupDetailResponse.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/18.
//

import Foundation

// MARK: - PublicGroupResponse

struct PublicGroupResponse: Codable {
    let publicGroupData: [PublicGroupData]
}

// MARK: - PublicGroupData

struct PublicGroupData: Codable {
    let groupName, groupTendency, groupDescription: String
    let groupTag: [String]
    let groupMembers: [String]
    let history: [History]
}


