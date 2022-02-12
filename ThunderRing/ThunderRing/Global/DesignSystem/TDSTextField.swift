//
//  TDSTextField.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/13.
//

import UIKit

import SnapKit
import Then

class BDSTextField: UITextField {
    
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
        self.setLeftPaddingPoints(15)
        self.setRightPaddingPoints(15)
        self.backgroundColor = .white
        self.tintColor = .purple100
        self.borderStyle = .none
    }
    
    // MARK: - Public Method
    
    public func setPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
}
