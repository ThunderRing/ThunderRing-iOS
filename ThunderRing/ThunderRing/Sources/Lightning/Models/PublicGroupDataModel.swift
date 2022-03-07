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

var publicGroupData : [PublicGroupDataModel] = [
    PublicGroupDataModel(groupImage: "imgFlog", groupName: "서울숲 플로깅", memberCounts: 4, publicGroupType: .diligent, memberTotalCounts: 100, description: "같이 깨끗한 지구 만들어요"),
    PublicGroupDataModel(groupImage: "imgFive", groupName: "05년생 모여", memberCounts: 7, publicGroupType: .crowd, memberTotalCounts: 10, description: "개그에 자신 있으신 분"),
    PublicGroupDataModel(groupImage: "imgStudent", groupName: "서울중학교", memberCounts: 4, publicGroupType: .cozy, memberTotalCounts: 300, description: "서울중 동창 모여라"),
    PublicGroupDataModel(groupImage: "imgGame", groupName: "닌텐도 할 사람", memberCounts: 3, publicGroupType: .soft, memberTotalCounts: 30, description: "고수만 들어오삼"),
    PublicGroupDataModel(groupImage: "imgGame", groupName: "닌텐도 할 사람", memberCounts: 3, publicGroupType: .soft, memberTotalCounts: 30, description: "고수만 들어오삼")
]

