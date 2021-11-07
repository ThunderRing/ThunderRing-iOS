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
}
