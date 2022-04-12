//
//  MyPrivateTVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/12/08.
//

import UIKit

import SnapKit
import Then

final class MyPrivateTableViewCell: UITableViewCell {
    static let identifier = "MyPrivateTableViewCell"
    
    // MARK: - Properties
    
    private var backView = UIView().then {
        $0.backgroundColor = .white
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 5, bounds: true)
    }
    
    private var groupImageView = UIImageView().then {
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 19, bounds: true)
    }
    
    private var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 17)
    }
    
    private var groupDescriptionLabel = UILabel().then {
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
    }

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .clear
        
        groupImageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 19, bounds: true)
    }
    
    private func setLayout() {
        contentView.addSubview(backView)
        backView.addSubviews([groupImageView,
                              groupNameLabel,
                              groupDescriptionLabel,
                              countLabel])
        
        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(3.5)
            $0.leading.trailing.equalToSuperview()
        }
        
        groupImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(19)
            $0.width.equalTo(53)
            $0.height.equalTo(55)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(14)
            $0.top.equalToSuperview().inset(22)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
        }
        
        groupDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(14)
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(5)
        }
    }
    
    internal func initCell(group: PrivateGroupDataModel) {
        if group.groupImageName != nil {
            groupImageView.image = UIImage(named: group.groupImageName!)
        } else {
            groupImageView.image = group.groupImage
        }
        
        groupNameLabel.text = group.groupName
        groupNameLabel.setTextSpacingBy(value: -0.6)
        
        groupDescriptionLabel.text = group.groupDescription
        groupDescriptionLabel.setTextSpacingBy(value: -0.6)
        
        countLabel.text = "\(group.memberCounts)"
    }
}
