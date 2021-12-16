//
//  PrivateGroupDataModel.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/16.
//

import UIKit

struct PrivateGroupDataModel {
    var groupImageName: String?
    var groupImage: UIImage?
    var groupName: String
    var memberCounts: Int
    
    var groupDescription: String?
}

var privateGroupData : [PrivateGroupDataModel] = [
    PrivateGroupDataModel(groupImageName: "imgDog1", groupName: "양파링걸즈", memberCounts: 4, groupDescription: "캡스톤 아자아자"),
    PrivateGroupDataModel(groupImageName: "imgHike", groupName: "대한 산악회", memberCounts: 22, groupDescription: "대한의 모든 산 정복을 위해"),
    PrivateGroupDataModel(groupImageName: "imgSwu", groupName: "서울여대 디미과", memberCounts: 80, groupDescription: "디지털미디어학과 18학번"),
    PrivateGroupDataModel(groupImageName: "imgBike", groupName: "5기 자전거동호회", memberCounts: 30, groupDescription: "매주 일요일 아침 정기모임")
]
