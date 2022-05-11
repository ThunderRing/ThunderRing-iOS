//
//  File.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/11.
//

import Foundation

// MARK: - ContactData Response

struct ContactDataResponse: Codable {
    let addressData: [ContactData]
}

// MARK: - ContactData

struct ContactData: Codable {
    let profileImageName, name: String
    let number: String
    let isUser: Bool
}
