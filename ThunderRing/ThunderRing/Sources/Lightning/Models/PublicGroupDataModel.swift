//
//  PublicGroupDataModel.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/16.
//

import Foundation

enum PublicGroupType {
    case cozy
    case crowd
    case diligent
    case emotion
    case soft
}

struct PublicGroupDataModel {
    var groupImage: String
    var groupName: String
    var memberCounts: Int
    var publicGroupType: PublicGroupType
    
    var memberTotalCounts: Int?
    var description: String?
}
