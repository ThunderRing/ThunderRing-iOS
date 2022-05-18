//
//  FirebaseDateService.swift
//  ThunderRing
//
//  Created by Hamin on 2022/04/16.
//

import Foundation
import Firebase

//root
fileprivate let baseRef = Database.database().reference()

class FirebaseDataService {
    
    static let instance = FirebaseDataService()
    
    let userRef = baseRef.child("users")
    
    let chatroomsRef = baseRef.child("chatrooms")
    
    //현재 접속중인 사용자의 uid
    var currentUserUid: String? {
        
        get{
            guard let uid = Auth.auth().currentUser?.uid else {return nil}
            return uid
        }
        
    }
    
}
