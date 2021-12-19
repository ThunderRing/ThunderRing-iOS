//
//  ThunderDataModel.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/26.
//

import Foundation

struct AlarmDataModel {
    var isThunder: Bool
    var isLightning: Bool
    var isFailed: Bool
    
    var lightningName: String
    var description: String
    var time: String
    var groupName: String
}

var alarmDatas : [AlarmDataModel] = [
    AlarmDataModel(isThunder: false, isLightning: true, isFailed: false, lightningName: "스벅가서 모각공", description: "채팅방에 먼저 참가해보세요", time: "1시간 전", groupName: "서울여대 디미과"),
    AlarmDataModel(isThunder: true, isLightning: false, isFailed: false, lightningName: "혜화역 혼카츠 먹자", description: "오후 6:00 | 혜화역 1번 출구", time: "30분 전", groupName: "양파링걸즈")
]
