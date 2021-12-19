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

var lightningDatas : [LightningDataModel] = [
    LightningDataModel(groupName: "양파링걸즈", lightningName: "혜화역 혼카츠 먹자", description: "", date: "10/27", time: "오전 11:00", location: "혜화", minNumber: 2, maxNumber: 4, members: ["이지원", "마예지"])
]
