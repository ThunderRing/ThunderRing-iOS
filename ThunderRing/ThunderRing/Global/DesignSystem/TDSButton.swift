//
//  TDSButton.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/13.
//

import UIKit

import SnapKit
import Then

final class TDSButton: UIButton {
    
    // MARK: - Properties
    
    var isActivated: Bool = false {
        didSet {
            self.backgroundColor = self.isActivated ? activatedBgColor : normalBgColor
            self.setTitleColor(self.isActivated ? activatedFontColor : normalFontColor, for: .normal)
            self.isEnabled = isActivated
        }
    }
    
    private var normalBgColor: UIColor = .gray200
    private var normalFontColor: UIColor = .gray150
    
    private var activatedBgColor: UIColor = .purple100
    private var activatedFontColor: UIColor = .white
    
    init() {
        super.init(frame: .zero)
        setLayout()
        setDefaultStyle()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLayout()
        setDefaultStyle()
    }
    
    // MARK: - Private Methods
    
    /// 디폴트 버튼 스타일 설정
    private func setDefaultStyle() {
        self.makeRounded(cornerRadius: 26.adjusted)
        self.titleLabel?.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        self.backgroundColor = self.normalBgColor
        self.tintColor = .white
        self.setTitleColor(self.normalFontColor, for: .normal)
    }
    
    private func setLayout() {

    }
    
    // MARK: - Public Methods
    
    public func setBtnColors(normalBgColor: UIColor, normalFontColor: UIColor, activatedBgColor: UIColor, activatedFontColor: UIColor) {
        self.normalBgColor = normalBgColor
        self.normalFontColor = normalFontColor
        self.activatedBgColor = activatedBgColor
        self.activatedFontColor = activatedFontColor
    }
    
    /// 버튼 타이틀과 스타일 변경 폰트 사이즈 adjusted 적용
    public func setTitleWithStyle(title: String, size: CGFloat, weight: FontWeight = .regular) {
        let font: UIFont
        
        switch weight {
        case .bold:
            font = .SpoqaHanSansNeo(type: .bold, size: size.adjusted)
        case .light:
            font = .SpoqaHanSansNeo(type: .light, size: size.adjusted)
        case .medium:
            font = .SpoqaHanSansNeo(type: .medium, size: size.adjusted)
        case .regular:
            font = .SpoqaHanSansNeo(type: .regular, size: size.adjusted)
        case .semiBold:
            font = .SpoqaHanSansNeo(type: .semiBold, size: size.adjusted)
        
        }
        
        self.titleLabel?.font = font
        self.setTitle(title, for: .normal)
    }
    
    public func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
