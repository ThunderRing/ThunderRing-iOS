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
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func initViewBorder(borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat, bounds: Bool) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = bounds
    }
}
