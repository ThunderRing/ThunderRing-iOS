//
//  UITextField+.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func initTextFieldBorder(borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat, bounds: Bool) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = bounds
    }
    
    func setLeftIcon(_ padding: CGFloat, _ size: CGFloat, _ icon: UIImage) {
        let padding = padding
        let size = size
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size + padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
    
    func setRightIcon(_ padding: CGFloat, _ size: CGFloat, _ icon: UIImage) {
        let padding = padding
        let size = size
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size + padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: -(padding), y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        rightView = outerView
        rightViewMode = .always
        
        outerView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpDeleteButton))
        outerView.addGestureRecognizer(gesture)
    }
    
    @objc func touchUpDeleteButton() {
        self.text = ""
    }
}
