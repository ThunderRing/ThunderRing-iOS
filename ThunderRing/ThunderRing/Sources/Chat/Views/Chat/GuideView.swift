//
//  GuideView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/19.
//

import UIKit

import SnapKit
import Then

final class GuideView: UIView {
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 12)
        $0.setTextSpacingBy(value: -4)
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = "\(title)"
            titleLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    init() {
        super.init(frame: .zero)
        setTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitle() {
        backgroundColor = .purple100.withAlphaComponent(0.1)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
