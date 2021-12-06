//
//  PrivateListTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/16.
//

import UIKit

import SnapKit
import Then

class PrivateListTVC: UITableViewCell {
    static let identifier = "PrivateListTVC"
    
    // MARK: - UI
    
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

extension PrivateListTVC {
    private func initUI() {
        self.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 0, bounds: true)
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
            $0.centerY.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(countImageView.snp.trailing).offset(2)
            $0.centerY.equalTo(countImageView.snp.centerY)
        }
    }
}

extension PrivateListTVC {
    func initCell(groupImage: String, groupName: String, count: Int) {
        if let image = UIImage(named: groupImage) {
            groupImageView.image = image
        }
        
        groupNameLabel.text = groupName
        
        countLabel.text = "\(count)"
    }
}
