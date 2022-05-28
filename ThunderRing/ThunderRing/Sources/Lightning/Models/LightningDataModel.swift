//
//  LightningDataModel.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/17.
//

import Foundation

struct LightningDataModel {
    var groupName: String
    var lightningName: String
    var description: String?
    var date: String
    var time: String
    var location: String
    var minNumber: Int
    var maxNumber: Int
    
    var members: [String]?
}

var lightningData = [
    LightningDataModel(groupName: "[젤리팟]",
                       lightningName: "젤리 먹자",
                       description: "연남동에 맛있는 젤리 가게가 있다는데 같이 먹으러 갈 사람 구한다",
                       date: "5월 25일",
                       time: "오후 8:00",
                       location: "연남동",
                       minNumber: 2,
                       maxNumber: 5,
                       members: ["proYeji", "btnPlueButton"])
]
