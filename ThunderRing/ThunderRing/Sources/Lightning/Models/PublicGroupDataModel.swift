//
//  PublicGroupDataModel.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/16.
//

import Foundation

struct PublicGroupDataModel {
    var groupImage: String
    var groupName: String
    var memberCounts: Int
    var hashTag: String
    
    var memberTotalCounts: Int?
    var description: String?
}

var publicGroupData : [PublicGroupDataModel] = [
    PublicGroupDataModel(groupImage: "imgFlog", groupName: "서울숲 플로깅", memberCounts: 4, hashTag: "부지런한 동틀녘", memberTotalCounts: 100),
    PublicGroupDataModel(groupImage: "imgFive", groupName: "05년생 모여", memberCounts: 7, hashTag: "북적이는 오후", memberTotalCounts: 10),
    PublicGroupDataModel(groupImage: "imgStudent", groupName: "서울중학교", memberCounts: 4, hashTag: "감성적인 새벽녘", memberTotalCounts: 300),
    PublicGroupDataModel(groupImage: "imgGame", groupName: "닌텐도 할 사람", memberCounts: 3, hashTag: "사근한 오전", memberTotalCounts: 30)
]

