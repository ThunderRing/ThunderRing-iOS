//
//  PublicListTVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/11/16.
//

import UIKit

import SnapKit
import Then

final class PublicListTableViewCell: UITableViewCell {
    static let identifier = "PublicListTableViewCell"
    
    // MARK: - Properties
    
    private var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgRabbit")
        $0.makeRounded(cornerRadius: 17)
    }
    
    private var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private lazy var groupTagView = GroupTagView(tagType: .diligent)

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
        self.addSubviews([groupImageView, groupNameLabel, countLabel, groupTagView])
        
        groupImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21)
            $0.width.equalTo(48)
            $0.height.equalTo(50)
            $0.centerY.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(14)
            $0.top.equalToSuperview().inset(19)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
        }
        
        groupTagView.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(14)
            $0.top.equalTo(countLabel.snp.bottom).offset(7)
            $0.width.equalTo(84)
        }
    }
    
    // MARK: - Custom Method
    
    func initCell(group: PublicGroupDataModel) {
        groupImageView.image = UIImage(named: group.groupImage)
        
        groupNameLabel.text = group.groupName
        
        countLabel.text = "\(group.memberCounts)"
        
        switch group.publicGroupType {
        case .diligent:
            groupTagView.tagType = .diligent
            groupTagView.snp.updateConstraints {
                $0.width.equalTo(95)
            }
        case .crowd:
            groupTagView.tagType = .crowd
            groupTagView.snp.updateConstraints {
                $0.width.equalTo(84)
            }
        case .emotion:
            groupTagView.tagType = .emotion
            groupTagView.snp.updateConstraints {
                $0.width.equalTo(95)
            }
        case .soft:
            groupTagView.tagType = .soft
            groupTagView.snp.updateConstraints {
                $0.width.equalTo(72)
            }
        case .cozy:
            groupTagView.tagType = .cozy
            groupTagView.snp.updateConstraints {
                $0.width.equalTo(84)
            }
        }
    }
}
