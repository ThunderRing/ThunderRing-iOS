//
//  PrivateListTVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/11/16.
//

import UIKit

import SnapKit
import Then

final class PrivateListTableViewCell: UITableViewCell {
    static let identifier = "PrivateListTableViewCell"
    
    // MARK: - Properties
    
    private lazy var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgRabbit")
        $0.makeRounded(cornerRadius: 17)
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var countLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
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
    }
    
    private func setLayout() {
        self.addSubviews([groupImageView, groupNameLabel, countLabel])
        
        groupImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.width.height.equalTo(54)
            $0.centerY.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(25)
            $0.centerY.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
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
