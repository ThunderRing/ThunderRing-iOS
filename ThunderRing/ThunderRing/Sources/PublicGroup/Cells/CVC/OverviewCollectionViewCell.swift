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
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 38, bounds: true)
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.text = "그룹이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 17)
    }
    
    private lazy var countLabel = UILabel().then {
        $0.text = "0/0"
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
        initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 5, bounds: true)
        groupTagView.makeRounded(cornerRadius: 3)
    }
    
    private func setLayout() {
        addSubviews([groupImageView, groupNameLabel, countLabel, groupTagView])
        
        groupImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.width.equalTo(74)
            $0.height.equalTo(76)
            $0.centerX.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(31)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(14)
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(3)
        }
        
        groupTagView.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(84)
            $0.height.equalTo(21)
        }
    }
    
    // MARK: - Custom Method
    
    internal func initCell(group: PublicGroupDataModel) {
        groupImageView.image = UIImage(named: group.groupImage)
        
        groupNameLabel.text = group.groupName
        countLabel.text = "\(group.memberCounts)/\(group.memberTotalCounts!)"
        
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
