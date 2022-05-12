//
//  LookDetailCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/12.
//

import UIKit

import SnapKit
import Then

final class OverviewCollectionViewCell: UICollectionViewCell {
    static let identifier = "OverviewCollectionViewCell"
    
    // MARK: - Properties
    
    private lazy var groupImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 27, bounds: true)
    }
    
    private var labelView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.text = "그룹이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 17)
    }
    
    private  var memberCountStr: String = ""
    
    private lazy var memberCountLabel = UILabel().then {
        $0.text = "0/000"
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 14)
    }
    
    private lazy var groupTagView = GroupTendencyView(tagType: .diligent)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        backgroundColor = .white
        initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 5, bounds: true)
        groupTagView.makeRounded(cornerRadius: 3)
    }
    
    private func setLayout() {
        addSubviews([groupImageView, labelView, groupTagView])
        labelView.addSubviews([groupNameLabel, memberCountLabel])
        
        groupImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.width.equalTo(74)
            $0.height.equalTo(76)
            $0.centerX.equalToSuperview()
        }
        
        labelView.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(21)
            $0.width.equalTo(96)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        memberCountLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.top)
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(3)
        }
        
        groupTagView.snp.makeConstraints {
            $0.top.equalTo(labelView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(84)
            $0.height.equalTo(21)
        }
    }
    
    // MARK: - Custom Method
    
    private func calculateViewWidth(groupName: String, memberCount: String) -> CGFloat {
        let groupNameLabel = UILabel()
        groupNameLabel.text = groupName
        groupNameLabel.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        groupNameLabel.sizeToFit()
        
        let memberCountLabel = UILabel()
        memberCountLabel.text = groupName
        memberCountLabel.font = .DINPro(type: .regular, size: 14)
        memberCountLabel.sizeToFit()
        
        return groupNameLabel.frame.width + memberCountLabel.frame.width
    }
    
    internal func initCell(_ data: PublicGroupData) {
        groupImageView.image = UIImage(named: data.groupImageName)

        memberCountStr = " \(data.groupMember.count)/\(data.groupMaxCount)"

        groupNameLabel.text = data.groupName
        groupNameLabel.setTextSpacingBy(value: -0.6)

        memberCountLabel.text = "\(data.groupMember.count)/\(data.groupMaxCount)"
        memberCountLabel.setTextSpacingBy(value: -0.6)

        let width = calculateViewWidth(groupName: data.groupName, memberCount: memberCountStr)
        labelView.snp.updateConstraints {
            $0.width.equalTo(width)
        }
        
        switch data.groupTendency {
        case "tendencyDiligent":
            groupTagView.tagType = .diligent
            groupTagView.snp.updateConstraints {
                $0.width.equalTo(95)
            }
        case "tendencyCrowd":
            groupTagView.tagType = .crowd
            groupTagView.snp.updateConstraints {
                $0.width.equalTo(84)
            }
        case "tendencyEmotion":
            groupTagView.tagType = .emotion
            groupTagView.snp.updateConstraints {
                $0.width.equalTo(95)
            }
        case "tendencySoft":
            groupTagView.tagType = .soft
            groupTagView.snp.updateConstraints {
                $0.width.equalTo(72)
            }
        case "tendencyCozy":
            groupTagView.tagType = .cozy
            groupTagView.snp.updateConstraints {
                $0.width.equalTo(84)
            }
        default:
            return 
        }
    }
}
