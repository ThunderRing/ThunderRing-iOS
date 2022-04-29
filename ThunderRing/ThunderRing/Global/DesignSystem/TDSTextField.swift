//
//  TDSTextField.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/13.
//

import UIKit

import SnapKit
import Then

class TDSTextField: UITextField {
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setDefaultStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
        setDefaultStyle()
    }
    
    // MARK: - Private Methods
    
    private func setLayout() {
        
    }
    
    private func setDefaultStyle() {
        self.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        self.backgroundColor = .white
        self.tintColor = .purple100
        self.layer.borderColor = UIColor.gray300.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.setLeftPaddingPoints(12)
        self.setRightPaddingPoints(12)
    }
    
    // MARK: - Public Method
    
    public func setPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
    
    public func setTintColor(tintColor: UIColor) {
        self.tintColor = tintColor
    }
}
