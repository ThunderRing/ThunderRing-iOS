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
        $0.image = UIImage(named: "image1")
        $0.layer.cornerRadius = $0.frame.width / 2
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var countLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    private func setLayout() {
        self.addSubviews([groupImageView, groupNameLabel, countLabel])
        
        groupImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(25)
            $0.centerY.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
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
