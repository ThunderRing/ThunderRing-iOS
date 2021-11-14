//
//  CardView.swift
//  ThunderRing
//
//  Created by HM on 2021/11/14.
//

import UIKit

@IBDesignable
class CardView: UIView {

    @IBInspectable var cornerradius: CGFloat = 7
    @IBInspectable var cardviewColor: UIColor = UIColor.purple

    override func layoutSubviews() {
        layer.cornerRadius = cornerradius
        layer.backgroundColor = cardviewColor.cgColor
    }

}
