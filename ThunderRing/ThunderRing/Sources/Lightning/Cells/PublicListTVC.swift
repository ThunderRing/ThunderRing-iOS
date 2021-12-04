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
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: $0.frame.width / 2, bounds: true)
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
    
    private var hashTagImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
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
        self.addSubviews([groupImageView, groupNameLabel, countLabel, hashTagImageView])
        
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
        
        hashTagImageView.snp.makeConstraints {
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
        
        switch hashTag {
        case "부지런한 동틀녘":
            hashTagImageView.image = UIImage(named: "tagDiligent")
        case "북적이는 오후":
            hashTagImageView.image = UIImage(named: "tagCrowd")
        case "감성적인 새벽녁]녘":
            hashTagImageView.image = UIImage(named: "tagEmotion")
        case "사근한 오전":
            hashTagImageView.image = UIImage(named: "tagSoft")
        case "포근한 해질녘":
            hashTagImageView.image = UIImage(named: "tagCozy")
        default:
            return
        }
    }
}
