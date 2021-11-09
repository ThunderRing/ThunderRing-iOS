//
//  UIFont+.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

extension UIFont {
    public enum SpoqaHanSansNeoType: String {
        case bold = "Bold"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case thin = "Thin"
    }
    
    static func SpoqaHanSansNeo(_ type: SpoqaHanSansNeoType, size: CGFloat) -> UIFont {
        return UIFont(name: "SpoqaHanSansNeo-\(type.rawValue)", size: size)!
    }
}
