//
//  ChatDataModel.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/04.
//

import UIKit

enum ChatType {
    case counterpart
    case me
}

class MessageData {
//    var chatType: ChatType
    var uid: String?
    var messageText: String?
    var timeStamp: Int?
    
    init(uid: String, comment: String, timeStamp: Int){
        self.uid = uid
        self.messageText = comment
        self.timeStamp = timeStamp
    }
    
    func makeImage(_ imageName: String) -> UIImage? {
        return UIImage(named: imageName)
    }
}

//var chatData : [MessageData] = [
//    MessageData(chatType: .counterpart, messageText: "안녕하세요\n모두 만나서 반갑습니다 !!", profileImageName: "imgBear", nickname: "마보리", sendTime: "오후 02:30"),
//    MessageData(chatType: .counterpart, messageText: "우와", profileImageName: "imgDog", nickname: "오복이", sendTime: "오후 02:35"),
//    MessageData(chatType: .counterpart, messageText: "우와 다들 너무 반가워요 !", profileImageName: "imgDog", nickname: "오복이", sendTime: "오후 02:35")
//]
