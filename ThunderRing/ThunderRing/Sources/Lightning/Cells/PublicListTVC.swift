//
//  PublicListTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/16.
//

import UIKit

import SnapKit
import Then

class PublicListTVC: UITableViewCell {
    static let identifier = "PublicListTVC"
    
    // MARK: - UI
    
    private var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "image1")
        $0.layer.cornerRadius = $0.frame.width / 2
        $0.layer.masksToBounds = false
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private var groupNameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private var hashTagLabel = UILabel().then {
        $0.textColor = .black
        $0.backgroundColor = .systemGray5
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
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

extension PublicListTVC {
    private func setLayout() {
        self.addSubviews([groupImageView, groupNameLabel, countLabel, hashTagLabel])
        
        groupImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.centerY.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
            $0.top.equalToSuperview().inset(24)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(8)
            $0.top.equalToSuperview().inset(24)
        }
        
        hashTagLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
            $0.top.equalTo(countLabel.snp.bottom).offset(7)
        }
    }
}

extension PublicListTVC {
    func initCell(groupImage: String, groupName: String, count: Int, hashTag: String) {
        if let image = UIImage(named: groupImage) {
            groupImageView.image = image
        }
        
        groupNameLabel.text = groupName
        
        countLabel.text = "\(count)"
        
        if hashTag == "감성적인 새벽녁" {
            hashTagLabel.text = "# \(hashTag)"
            hashTagLabel.textColor = .white
            hashTagLabel.backgroundColor = .purple
            hashTagLabel.snp.makeConstraints {
                $0.width.equalTo(111)
                $0.height.equalTo(21)
            }
        }
    }
}
