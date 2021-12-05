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

struct MessageData {
    var chatType: ChatType
    var messageText: String
    var profileImageName: String
    var nickname: String
    var sendTime: String
    
    func makeImage(_ imageName: String) -> UIImage? {
        return UIImage(named: imageName)
    }
}

var chatData : [MessageData] = [
    MessageData(chatType: .counterpart, messageText: "안녕하세요\n모두 만나서 반갑습니다 !!", profileImageName: "15", nickname: "마보리", sendTime: "오후 02:30"),
    MessageData(chatType: .counterpart, messageText: "우와", profileImageName: "imgRabbit", nickname: "오복이", sendTime: "오후 02:35"),
    MessageData(chatType: .counterpart, messageText: "우와 다들 너무 반가워요 !", profileImageName: "imgRabbit", nickname: "오복이", sendTime: "오후 02:35"),
    MessageData(chatType: .me, messageText: "다들 너무 반가워요 !\n얼른 먹으러 가고싶네요 ㅠ^ㅠ", profileImageName: "", nickname: "", sendTime: "오후 03:30")
]
