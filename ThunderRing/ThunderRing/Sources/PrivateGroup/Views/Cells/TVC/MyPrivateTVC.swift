//
//  MyPrivateTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/08.
//

import UIKit

class MyPrivateTVC: UITableViewCell {
    static let identifier = "MyPrivateTVC"
    
    // MARK: - UI
    
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

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension MyPrivateTVC {
    private func initUI() {
        self.backgroundColor = .white
        self.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 0, bounds: true)
        
        groupImageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 37, bounds: true)
        
        [groupNameLabel, groupDescriptionLabel, countLabel].forEach {
            $0.addCharacterSpacing()
        }
    }
    
    private func setLayout() {
        addSubviews([groupImageView, groupNameLabel, groupDescriptionLabel, countImageView, countLabel])
        
        groupImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(33)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(75)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
            $0.top.equalToSuperview().inset(50)
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
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(7)
        }
    }
}

extension MyPrivateTVC {
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
