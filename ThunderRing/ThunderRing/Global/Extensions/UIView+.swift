//
//  UIView+.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func initViewBorder(borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat, bounds: Bool) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = bounds
    }
}
