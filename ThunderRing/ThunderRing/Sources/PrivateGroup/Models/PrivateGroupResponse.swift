//
//  PrivageGroupDetailResponse.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/18.
//

import Foundation

// MARK: - PrivateGroupDetailResponse

struct PrivateGroupResponse: Codable {
    let privateGroupData: [PrivateGroupData]
}

// MARK: - PrivateGroupDetailData

struct PrivateGroupData: Codable {
    let groupImageName: String
    let groupName, groupDescription: String
    let groupMember: [GroupMember]
    let history: [History]
}

// MARK: - History

struct GroupMember: Codable {
    let memberImageName, memberName: String
}

// MARK: - History

struct History: Codable {
    let date, lightningName: String
    let memberCount: Int
    let location: String
}
