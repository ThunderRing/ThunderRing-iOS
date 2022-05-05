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
    LightningDataModel(groupName: "[독서모임]",
                       lightningName: "Post Poetics 방문해요",
                       description: "",
                       date: "10/26",
                       time: "오전 11:00",
                       location: "이태원역",
                       minNumber: 3,
                       maxNumber: 7,
                       members: ["imgCoin", "btnPlueButton"])
]
