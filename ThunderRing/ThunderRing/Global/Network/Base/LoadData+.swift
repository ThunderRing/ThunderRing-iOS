//
//  LoadData+.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/04.
//

import UIKit

extension UIViewController {
    internal func loadPrivateGroupData() -> Data? {
        let fileNm: String = "PrivateGroupData"
        let extensionType = "json"
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            print("파일 로드 실패")
            return nil
        }
    }
    
    internal func loadPublicGroupData() -> Data? {
        let fileNm: String = "PublicGroupData"
        let extensionType = "json"
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            print("파일 로드 실패")
            return nil
        }
    }
}
