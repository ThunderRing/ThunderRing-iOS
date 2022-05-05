//
//  CountLabelView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/06.
//

import UIKit

import SnapKit
import Then

final class CountLabelView: UIView {
    var count: Int = 0 {
        didSet {
            titleLabel.text = "잔여 \(count)자리"
            titleLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
    }
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .purple100
        makeRounded(cornerRadius: 15.5)
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
