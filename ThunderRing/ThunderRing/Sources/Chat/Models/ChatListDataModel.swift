//
//  ChatListDataModel.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/14.
//

import Foundation

class ChatListDataModel {
    
    var key: String?
    var destinationUID: String?
    var imageName: String?
    var groupName: String?
    var thunderName: String?
    var countUsers: Int?
    var contentLabel: String?
    var timeStamp: Int?
    var chatCount: Int?
    
    init(key: String, destinationUID: String, imageName: String, groupName: String, thunderName: String, countUsers: Int, contentLabel: String, timeStamp: Int, chatCount: Int) {
        self.key = key
        self.destinationUID = destinationUID
        self.imageName = imageName
        self.groupName = groupName
        self.thunderName = thunderName
        self.countUsers = countUsers
        self.contentLabel = contentLabel
        self.timeStamp = timeStamp
        self.chatCount = chatCount
    }
}
