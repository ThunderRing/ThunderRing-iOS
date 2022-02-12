//
//  ThunderDataModel.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/26.
//

import Foundation

enum AlarmType {
    case thunder
    case lightning
    case failed
}

struct AlarmDataModel {
    var alarmType: AlarmType
    var lightningName: String
    var description: String
    var time: String
    var groupName: String
}

var alarmData : [AlarmDataModel] = [
    AlarmDataModel(alarmType: .lightning, lightningName: "혜화역 혼카츠 먹자", description: "오후 6:00 | 혜화역 1번 출구", time: "30분 전", groupName: "양파링걸즈")
]
