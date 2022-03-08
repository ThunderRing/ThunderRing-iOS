//
//  HomeHeaderView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/08.
//

import UIKit

import SnapKit
import Then

final class HomeMainHeaderView: UIView {
    
    var title = "" {
        didSet { titleLabel.text = title }
    }
    
    var count = 0 {
        didSet { }
    }
    
    var isMoreEnabled = true {
        didSet { moreButton.isHidden = isMoreEnabled }
    }

    private lazy var titleLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 18)
    }
    
    private lazy var countLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 18)
    }

    private lazy var moreButton = MoreButton()
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        addSubviews([titleLabel, countLabel, moreButton])
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalToSuperview().inset(27)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
        }

        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(25)
            $0.width.equalTo(75)
            $0.height.equalTo(28)
        }
    }
}

// MARK: - All Button

fileprivate final class MoreButton: UIButton {
    
    // MARK: - Properties
    
    private lazy var textLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 12)
        $0.text = "전체보기"
        $0.textColor = .gray100
        $0.backgroundColor = .background
        $0.textAlignment = .center
    }

    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - InitUI
    
    private func setButton() {
        self.layer.borderColor = UIColor.gray100.cgColor
        self.layer.borderWidth = 1
        
        self.makeRounded(cornerRadius: 14)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(6)
        }
    }
}
