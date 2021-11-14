//
//  UIFont+.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

extension UIFont {
    class func SpoqaHanSansNeo(type: SpoqaHanSansNeoType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.name, size: size) else { return UIFont.init() }
        
        return font
    }

    enum SpoqaHanSansNeoType: String {
        case bold = "Bold"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "semiBold"
        
        var name: String {
            return "SpoqaHanSansNeo-" + self.rawValue
        }
    }
}
