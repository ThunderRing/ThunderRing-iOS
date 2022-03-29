//
//  HomePublicGroupCollectionViewCellView.swift
//  ThunderRing
//
//  Created by soyeon on 2022/03/05.
//

import UIKit

import SnapKit
import Then

final class HomeMainPublicGroupCollectionViewCellView: UIView {
    
    // MARK: - Properties
    
    private lazy var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgJuju")
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.text = "그룹이름"
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 17)
    }
    
    private lazy var memberCountLabel = UILabel().then {
        $0.text = "0/000"
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private lazy var groupTagView = GroupTagView(tagType: .diligent)
    
    private var lightningButton = LightningButton()
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        groupImageView.makeRounded(cornerRadius: 28)
        
        lightningButton.makeRounded(cornerRadius: 14 )
        
        groupTagView.makeRounded(cornerRadius: 3)
    }
    
    private func setLayout() {
        addSubviews([groupImageView,
                     groupNameLabel,
                     memberCountLabel,
                     groupTagView,
                     lightningButton])
        
        groupImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(74)
            $0.height.equalTo(74)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(30)
        }
        
        memberCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(groupNameLabel.snp.bottom)
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(4)
        }
        
        groupTagView.snp.makeConstraints {
            $0.top.equalTo(memberCountLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(84)
            $0.height.equalTo(21)
        }
        
        lightningButton.snp.makeConstraints {
            $0.top.equalTo(groupTagView.snp.bottom).offset(15)
            $0.width.equalTo(88)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func calculateViewWidth(text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        label.sizeToFit()
        return label.frame.width + 12
    }
    
    internal func configCell(group: PublicGroupDataModel) {
        groupImageView.image = UIImage(named: group.groupImage)
        
        groupNameLabel.text = group.groupName
        
        memberCountLabel.text = "\(group.memberCounts)/\(group.memberTotalCounts!)"
        
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

// MARK: - Custom Button

fileprivate final class LightningButton: UIButton {
    private lazy var textLabel = UILabel().then {
        $0.text = "번개"
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
        $0.textColor = .white
        $0.textAlignment = .center
    }

    init() {
        super.init(frame: .zero)
        setButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setButton() {
        self.makeRounded(cornerRadius: 14)
        self.backgroundColor = .purple100
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
