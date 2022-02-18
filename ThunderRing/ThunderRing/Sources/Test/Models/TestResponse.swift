//
//  TestResponse.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/19.
//

import Foundation

// MARK: - TestResponse

struct TestResponse: Codable {
    let testData: [TestData]
}

// MARK: - TestData

struct TestData: Codable {
    let question: String
    let answer: [String]
}

