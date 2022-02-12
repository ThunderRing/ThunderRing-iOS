//
//  MainPrivateCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/16.
//

import UIKit

import SnapKit
import Then

final class PrivateGroupCVC: UICollectionViewCell {
    static let identifier = "MainPrivateCVC"
    
    // MARK: - Properties
    
    private lazy var backView = UIView().then {
        $0.backgroundColor = .white
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 5, bounds: true)
    }
    
    private var groupImageView = UIImageView().then {
        $0.layer.borderColor = UIColor.gray300.cgColor
    }
    
    private var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 18)
    }
    
    private var groupDescriptionLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private var countImageView = UIImageView().then {
        $0.image = UIImage(named: "icnUser")
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private var enterButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnEnter"), for: .normal)
    }
    
    private var lightningButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnLightning"), for: .normal)
    }

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        groupImageView.layer.cornerRadius = 37
        groupImageView.layer.masksToBounds = true
    }
    
    private func setupLayout() {
        self.addSubviews([backView, groupImageView, groupNameLabel, groupDescriptionLabel, countImageView, countLabel, enterButton, lightningButton])
        
        backView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview().inset(2)
        }
        
        groupImageView.snp.makeConstraints {
            $0.leading.equalTo(backView.snp.leading).offset(18)
            $0.top.equalTo(backView.snp.top).offset(36)
            $0.width.height.equalTo(75)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(backView.snp.top).offset(29)
            $0.leading.equalTo(groupImageView.snp.trailing).offset(9)
        }
        
        countImageView.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(countImageView.snp.trailing).offset(3)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
        }
        
        groupDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(7)
            $0.leading.equalTo(groupImageView.snp.trailing).offset(9)
        }
        
        enterButton.snp.makeConstraints {
            $0.top.equalTo(groupDescriptionLabel.snp.bottom).offset(2)
            $0.leading.equalTo(groupImageView.snp.trailing).offset(9)
        }
        
        lightningButton.snp.makeConstraints {
            $0.top.equalTo(groupDescriptionLabel.snp.bottom).offset(2)
            $0.leading.equalTo(enterButton.snp.trailing).offset(9)
        }
    }
}

// MARK: - Custom Method

extension PrivateGroupCVC {
    func initCell(group: PrivateGroupDataModel) {
        if group.groupImageName != nil {
            groupImageView.image = UIImage(named: group.groupImageName!)
        } else {
            groupImageView.image = group.groupImage
        }
        
        groupNameLabel.text = group.groupName
        groupDescriptionLabel.text = group.groupDescription
        countLabel.text = "\(group.memberCounts)"
    }
}
