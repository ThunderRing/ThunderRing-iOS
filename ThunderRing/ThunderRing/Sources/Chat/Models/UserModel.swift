//
//  UserModel.swift
//  ThunderRing
//
//  Created by Hamin on 2022/04/17.
//

import UIKit

class UserModel: NSObject {
    
    var imageName: String?
    var name: String?
    var uid: String?
    var tendency: String?
    var groups: Dictionary<String, String>
    
    init(uid: String, name: String, imageName: String, tendency: String) {
        self.uid = uid
        self.name = name
        self.imageName = imageName
        self.tendency = tendency
        self.groups = [:]
    }
}
