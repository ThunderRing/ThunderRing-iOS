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
        $0.makeRounded(cornerRadius: 17)
    }
    
    private var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .gray150
        $0.font = .DINPro(type: .regular, size: 15)
    }
    
    private lazy var groupTendencyView = GroupTendencyView(tagType: .diligent).then {
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
    
    // MARK: - Init UI
    
    private func configUI() {
        initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 1, bounds: true)
    }
    
    private func setLayout() {
        addSubviews([groupImageView, groupNameLabel, countLabel, groupTendencyView])
        
        groupImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(21)
            $0.width.equalTo(48)
            $0.height.equalTo(50)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(14)
            $0.top.equalToSuperview().inset(19)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(groupNameLabel.snp.centerY)
        }
        
        groupTendencyView.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(14)
            $0.top.equalTo(countLabel.snp.bottom).offset(7)
            $0.width.equalTo(84)
            $0.height.equalTo(21)
        }
    }
    
    // MARK: - Custom Method
    
    func initCell(_ data: PublicGroupData) {
        groupImageView.image = UIImage(named: data.groupImageName)
        
        groupNameLabel.text = data.groupName
        groupNameLabel.setTextSpacingBy(value: -0.6)
        
        countLabel.text = "\(data.groupMember.count)"
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
