//
//  PublicListTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/16.
//

import UIKit

import SnapKit
import Then

final class PublicListTVC: UITableViewCell {
    static let identifier = "PublicListTVC"
    
    // MARK: - Properties
    
    private var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgRabbit")
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 27, bounds: true)
    }
    
    private var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var countImageView = UIImageView().then {
        $0.image = UIImage(named: "icnUser")
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private var hashTagLabel = UILabel().then {
        $0.textColor = .gray100
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
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        self.layer.borderColor = UIColor.gray350.cgColor
        self.layer.borderWidth = 1
    }
    
    private func setLayout() {
        self.addSubviews([groupImageView, groupNameLabel, countImageView, countLabel, hashTagImageView])
        
        groupImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.width.height.equalTo(54)
            $0.centerY.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
            $0.top.equalToSuperview().inset(24)
        }
        
        countImageView.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(countImageView.snp.trailing).offset(2)
            $0.centerY.equalTo(countImageView.snp.centerY)
        }
        
        hashTagImageView.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
            $0.top.equalTo(countLabel.snp.bottom).offset(9)
        }
    }
    
    // MARK: - Custom Method
    
    func initCell(group: PublicGroupDataModel) {
        groupImageView.image = UIImage(named: group.groupImage)
        
        groupNameLabel.text = group.groupName
        
        countLabel.text = "\(group.memberCounts)"
        
        switch group.publicGroupType {
        case .diligent:
            hashTagImageView.image = UIImage(named: "tagDiligent")
        case .crowd:
            hashTagImageView.image = UIImage(named: "tagCrowd")
        case .emotion:
            hashTagImageView.image = UIImage(named: "tagEmotion")
        case .soft:
            hashTagImageView.image = UIImage(named: "tagSoft")
        case .cozy:
            hashTagImageView.image = UIImage(named: "tagCozy")
        }
    }
}
