//
//  TDSLightningButton.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/04.
//

import UIKit

import SnapKit
import Then

final class TDSGroupLightningButton: UIButton {
    
    private lazy var iconImage = UIImageView().then {
        $0.image = UIImage(named: "icn_lightning_new")
    }
    
    private lazy var label = UILabel().then {
        $0.text = "번개 치기"
        $0.textColor = .white
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
    }
    
    init() {
        super.init(frame: .zero)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        backgroundColor = .purple100
        addSubviews([iconImage, label])
        iconImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(127)
        }
        label.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
        }
    }
}
