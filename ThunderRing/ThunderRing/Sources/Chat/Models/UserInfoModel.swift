//
//  UserInfoModel.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/18.
//

import Foundation

class UserInfoModel {
    
    var userName: String?
    var profileImageName: String?
    var uid: String?
    
    init(uid: String, userName: String, profileImageName: String){
        
        self.uid = uid
        self.userName = userName
        self.profileImageName = profileImageName
    }

}
