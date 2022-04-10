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
    
    private lazy var leftIconImageView = UIImageView()
    
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
        makeRounded(cornerRadius: 26.adjusted)
        titleLabel?.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        backgroundColor = self.normalBgColor
        tintColor = .white
        setTitleColor(self.normalFontColor, for: .normal)
    }
    
    private func setLayout() {
        addSubview(leftIconImageView)
        leftIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(titleLabel!.snp.leading).offset(-4)
        }
    }
    
    // MARK: - Public Methods
    
    public func setBtnColors(normalBgColor: UIColor, normalFontColor: UIColor, activatedBgColor: UIColor, activatedFontColor: UIColor) {
        self.normalBgColor = normalBgColor
        self.normalFontColor = normalFontColor
        self.activatedBgColor = activatedBgColor
        self.activatedFontColor = activatedFontColor
    }
    
    /// 버튼 타이틀과 스타일 변경 폰트 사이즈 adjusted 적용
    internal func setTitleWithStyle(title: String, size: CGFloat, weight: FontWeight = .regular) {
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
        
        titleLabel?.font = font
        setTitle(title, for: .normal)
    }
    
    internal func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    internal func setCornerRadius(radius: CGFloat) {
        makeRounded(cornerRadius: radius)
    }
    
    internal func setLeftIconImage(imageName: String) {
        leftIconImageView.image = UIImage(named: imageName)
    }
}
