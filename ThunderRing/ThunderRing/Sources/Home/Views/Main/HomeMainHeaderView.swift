//
//  HomeHeaderView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/08.
//

import UIKit

import SnapKit
import Then

protocol HomeMainHeaderViewDelegate: AnyObject {
    func touchUpPrivateGroup()
    func touchUpPublicGroup()
}

enum GroupType {
    case privateGroup
    case publicGroup
}

final class HomeMainHeaderView: UIView {
    
    var title = "" {
        didSet {
            titleLabel.text = title
            titleLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var count = 0 {
        didSet { countLabel.text = "\(count)" }
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
        $0.font = .DINPro(type: .medium, size: 18)
    }

    private lazy var moreButton = MoreButton().then {
        if groupType == .privateGroup {
            $0.addTarget(self, action: #selector(touchUpMorePrivateGroup), for: .touchUpInside)
        } else {
            $0.addTarget(self, action: #selector(touchUpMorePublicGroup), for: .touchUpInside)
        }
    }
    
    private lazy var groupType: GroupType = .privateGroup
    
    weak var delegate: HomeMainHeaderViewDelegate?
    
    init(groupType: GroupType) {
        super.init(frame: .zero)
        self.groupType = groupType
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
            $0.top.equalToSuperview().inset(26)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }

        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(25)
            $0.width.equalTo(75)
            $0.height.equalTo(28)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpMorePrivateGroup() {
        delegate?.touchUpPrivateGroup()
    }
    
    @objc func touchUpMorePublicGroup() {
        delegate?.touchUpPublicGroup()
    }
}

// MARK: - All Button

fileprivate final class MoreButton: UIButton {
    
    // MARK: - Properties
    
    private lazy var textLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 12)
        $0.text = "전체보기"
        $0.setTextSpacingBy(value: -0.6)
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
        layer.borderColor = UIColor.gray100.cgColor
        layer.borderWidth = 1
        
        makeRounded(cornerRadius: 14)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(6)
        }
    }
}

