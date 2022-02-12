//
//  PrivateListTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/16.
//

import UIKit

import SnapKit
import Then

final class PrivateListTVC: UITableViewCell {
    static let identifier = "PrivateListTVC"
    
    // MARK: - Properties
    
    private lazy var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgRabbit")
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 27, bounds: true)
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var countImageView = UIImageView().then {
        $0.image = UIImage(named: "icnUser")
    }
    
    private lazy var countLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 0, bounds: true)
        
        [groupNameLabel, countLabel].forEach {
            $0.addCharacterSpacing()
        }
    }
    
    private func setLayout() {
        self.addSubviews([groupImageView, groupNameLabel, countImageView, countLabel])
        
        groupImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.width.height.equalTo(54)
            $0.centerY.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(25)
            $0.centerY.equalToSuperview()
        }
        
        countImageView.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(countImageView.snp.trailing).offset(2)
            $0.centerY.equalTo(countImageView.snp.centerY)
        }
    }
    
    // MARK: - Custom Method
    
    func initCell(group: PrivateGroupDataModel) {
        guard let groupImageName = group.groupImageName else { return }
        groupImageView.image = UIImage(named: groupImageName)
        
        groupNameLabel.text = group.groupName
        countLabel.text = "\(group.memberCounts)"
    }
}
