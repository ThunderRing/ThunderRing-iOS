//
//  PrivateGroupDataModel.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/16.
//

import Foundation

struct PrivateGroupDataModel {
    var groupImage: String
    var groupName: String
    var memberCounts: Int
    
    var groupDescription: String?
}

var privateGroupData : [PrivateGroupDataModel] = [
    PrivateGroupDataModel(groupImage: "imgRabbit", groupName: "양파링걸즈", memberCounts: 4, groupDescription: "우린 양파링은 킹왕짱이다"),
    PrivateGroupDataModel(groupImage: "imgCrong", groupName: "크롱", memberCounts: 4, groupDescription: "크롱크롱 크롱크크크롱"),
    PrivateGroupDataModel(groupImage: "imgButterfly", groupName: "오렌지쥬스", memberCounts: 7, groupDescription: "착즙주스 사랑해"),
    PrivateGroupDataModel(groupImage: "imgJuju", groupName: "마법사쥬쥬", memberCounts: 5, groupDescription: "들어오고 싶으면 주문을 외워")
]
