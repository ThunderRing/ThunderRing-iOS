//
//  MyGroupTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/10.
//

import UIKit

import SnapKit
import Then

final class MyPublicGroupTableViewCell: UITableViewCell {
    static var cellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private var backView = UIView().then {
        $0.backgroundColor = .white
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 5, bounds: true)
    }
    
    private var groupImageView = UIImageView().then {
        $0.layer.borderColor = UIColor.gray300.cgColor
    }
    
    private var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 17)
    }
    
    private var groupDescriptionLabel = UILabel().then {
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 15)
    }
    
    private var groupTendencyView = GroupTendencyView(tagType: .emotion).then {
        $0.makeRounded(cornerRadius: 3)
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
    
    private func configUI() {
        backgroundColor = .clear
        
        groupImageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 19, bounds: true)
    }
    
    private func setLayout() {
        contentView.addSubview(backView)
        backView.addSubviews([groupImageView,
                              groupNameLabel,
                              groupDescriptionLabel,
                              countLabel,
                              groupTendencyView])
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(7)
            $0.leading.trailing.equalToSuperview()
        }
        
        groupImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
            $0.leading.equalToSuperview().inset(18)
            $0.width.equalTo(53)
            $0.height.equalTo(55)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(14)
            $0.top.equalToSuperview().inset(17)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
        }
        
        groupDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(14)
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(5)
        }
        
        groupTendencyView.snp.makeConstraints {
            $0.top.equalTo(groupDescriptionLabel.snp.bottom).offset(5)
            $0.leading.equalTo(groupImageView.snp.trailing).offset(14)
            $0.width.equalTo(84)
            $0.height.equalTo(21)
        }
    }
    
    internal func initCell(_ data: PublicGroupData) {
        groupImageView.image = UIImage(named: data.groupImageName)
        
        groupNameLabel.text = data.groupName
        groupNameLabel.setTextSpacingBy(value: -0.6)
        
        groupDescriptionLabel.text = data.groupDescription
        groupDescriptionLabel.setTextSpacingBy(value: -0.6)
        
        countLabel.text = "\(data.groupMember.count)/ \(data.groupMaxCount)"
        countLabel.setTextSpacingBy(value: -0.6)
        
        switch data.groupTendency {
        case "tendencyDiligent":
            groupTendencyView.tagType = .diligent
            groupTendencyView.snp.updateConstraints {
                $0.width.equalTo(98)
            }
        case "tendencyCrowd":
            groupTendencyView.tagType = .crowd
            groupTendencyView.snp.updateConstraints {
                $0.width.equalTo(87)
            }
        case "tendencyEmotion":
            groupTendencyView.tagType = .emotion
            groupTendencyView.snp.updateConstraints {
                $0.width.equalTo(98)
            }
        case "tendencySoft":
            groupTendencyView.tagType = .soft
            groupTendencyView.snp.updateConstraints {
                $0.width.equalTo(75)
            }
        case "tendencyCozy":
            groupTendencyView.tagType = .cozy
            groupTendencyView.snp.updateConstraints {
                $0.width.equalTo(87)
            }
        default:
            groupTendencyView.tagType = .diligent
        }
    }
}
