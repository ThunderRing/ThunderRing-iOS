//
//  OverviewPublicGroupData.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/12.
//

import Foundation

// MARK: - OverviewPublicGroupResponse

struct OverviewPublicGroupResponse: Codable {
    let diligentGroupData, softGroupData, crowdGroupData, cozyGroupData, emotionGroupData: [PublicGroupData]
    
    enum CodingKeys: String, CodingKey {
        case diligentGroupData = "DiligentGroupData"
        case softGroupData = "SoftGroupData"
        case crowdGroupData = "CrowdGroupData"
        case cozyGroupData = "CozyGroupData"
        case emotionGroupData = "EmotionGroupData"
    }
}
