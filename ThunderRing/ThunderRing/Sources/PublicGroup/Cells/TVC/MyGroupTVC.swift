//
//  MyGroupTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/10.
//

import UIKit

class MyGroupTVC: UITableViewCell {
    static let identifier = "MyGroupTVC"
    
    // MARK: - UI
    
    var backView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var groupImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 38, bounds: true)
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 18)
    }
    
    private lazy var countImageView = UIImageView().then {
        $0.image = UIImage(named: "icnUser")
    }
    
    private lazy var countLabel = UILabel().then {
        $0.text = "0/0"
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private lazy var hashTagImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
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

extension MyGroupTVC {
    private func initUI() {
        self.backgroundColor = .background
        
        backView.layer.borderColor = UIColor.gray350.cgColor
        backView.layer.borderWidth = 1
        backView.layer.addBorder([.bottom], color: UIColor.gray350, width: 2)
    }
    
    private func setLayout() {
        self.addSubviews([backView, groupImageView, groupNameLabel, countImageView, countLabel, descriptionLabel, hashTagImageView])
        
        backView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview()
        }
        
        groupImageView.snp.makeConstraints {
            $0.leading.equalTo(backView.snp.leading).offset(31)
            $0.centerY.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
            $0.top.equalToSuperview().inset(37)
        }
        
        countImageView.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(countImageView.snp.trailing).offset(3)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(7)
        }
        
        hashTagImageView.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(15)
        }
    }
}

extension MyGroupTVC {
    func initCell(group: PublicGroupDataModel) {
        groupImageView.image = UIImage(named: group.groupImage)
        
        groupNameLabel.text = group.groupName
        countLabel.text = "\(group.memberCounts)/\(group.memberTotalCounts!)"
        
        descriptionLabel.text = group.description
        
        switch group.hashTag {
        case "부지런한 동틀녘":
            hashTagImageView.image = UIImage(named: "tagDiligent")
        case "북적이는 오후":
            hashTagImageView.image = UIImage(named: "tagCrowd")
        case "감성적인 새벽녘":
            hashTagImageView.image = UIImage(named: "tagEmotion")
        case "사근한 오전":
            hashTagImageView.image = UIImage(named: "tagSoft")
        case "포근한 해질녘":
            hashTagImageView.image = UIImage(named: "tagCozy")
        default:
            return
        }
        hashTagImageView.contentMode = .scaleAspectFit
    }
}
