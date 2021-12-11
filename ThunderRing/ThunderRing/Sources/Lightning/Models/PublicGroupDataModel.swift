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
    PublicGroupDataModel(groupImage: "imgRice", groupName: "Rice ball", memberCounts: 4, hashTag: "부지런한 동틀녘", memberTotalCounts: 100),
    PublicGroupDataModel(groupImage: "imgBear", groupName: "곰돌아이", memberCounts: 4, hashTag: "북적이는 오후", memberTotalCounts: 10),
    PublicGroupDataModel(groupImage: "imgNintendo", groupName: "동물의 숲", memberCounts: 3, hashTag: "감성적인 새벽녘", memberTotalCounts: 30),
    PublicGroupDataModel(groupImage: "imgDog", groupName: "이지언니", memberCounts: 4, hashTag: "사근한 오전", memberTotalCounts: 300)
]

