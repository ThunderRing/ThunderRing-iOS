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
    case cancel
}

struct AlarmDataModel {
    var alarmType: AlarmType
    var lightningName: String
    var description: String
    var time: String
    var groupName: String
}
