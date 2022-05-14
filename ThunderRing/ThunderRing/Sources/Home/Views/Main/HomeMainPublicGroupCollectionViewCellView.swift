//
//  HomePublicGroupCollectionViewCellView.swift
//  ThunderRing
//
//  Created by soyeon on 2022/03/05.
//

import UIKit

import SnapKit
import Then

protocol HomeMainPublicGroupCollectionViewCellViewDelegate: AnyObject {
    func touchUpButton(index: Int)
}

final class HomeMainPublicGroupCollectionViewCellView: UIView {
    
    // MARK: - Properties
    
    private lazy var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgJuju")
        $0.contentMode = .scaleAspectFill
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
    
    private lazy var groupTendencyView = GroupTendencyView(tagType: .diligent)
    
    private lazy var lightningButton = LightningButton().then {
        $0.addTarget(self, action: #selector(touchUpLightningButton), for: .touchUpInside)
    }
    
    weak var delegate: HomeMainPublicGroupCollectionViewCellViewDelegate?
    
    var index: Int = 0
    
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
        backgroundColor = .white
        
        groupImageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 27, bounds: true)
        
        lightningButton.makeRounded(cornerRadius: 14)
        
        groupTendencyView.makeRounded(cornerRadius: 3)
    }
    
    private func setLayout() {
        addSubviews([groupImageView,
                     labelView,
                     groupTendencyView,
                     lightningButton])
        labelView.addSubviews([groupNameLabel, memberCountLabel])
        
        groupImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(74)
            $0.height.equalTo(76)
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
        
        groupTendencyView.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(84)
            $0.height.equalTo(21)
        }
        
        lightningButton.snp.makeConstraints {
            $0.top.equalTo(groupTendencyView.snp.bottom).offset(15)
            $0.width.equalTo(88)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func calculateViewWidth(groupName: String, memberCount: String) -> CGFloat {
        let groupNameLabel = UILabel()
        groupNameLabel.text = groupName
        groupNameLabel.setTextSpacingBy(value: -0.6)
        groupNameLabel.font = .SpoqaHanSansNeo(type: .medium, size: 17)
        groupNameLabel.sizeToFit()
        
        let memberCountLabel = UILabel()
        memberCountLabel.text = memberCount
        memberCountLabel.setTextSpacingBy(value: -0.6)
        memberCountLabel.font = .DINPro(type: .regular, size: 14)
        memberCountLabel.sizeToFit()
        
        return groupNameLabel.frame.width + memberCountLabel.frame.width
    }
    
    internal func configCell(_ data: PublicGroupData) {
        groupImageView.image = UIImage(named: data.groupImageName)
        
        groupNameLabel.text = data.groupName
        groupNameLabel.setTextSpacingBy(value: -0.6)
        
        memberCountLabel.text = "\(data.groupMember.count)/\(data.groupMaxCount)"
        memberCountLabel.setTextSpacingBy(value: -0.6)
        
        let width = calculateViewWidth(groupName: data.groupName,
                                       memberCount: "\(data.groupMember.count)/\(data.groupMaxCount)")
        labelView.snp.updateConstraints {
            $0.width.equalTo(width)
            $0.centerX.equalToSuperview()
        }
        
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
    
    // MARK: - @objc
    
    @objc func touchUpLightningButton() {
        delegate?.touchUpButton(index: index)
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
        makeRounded(cornerRadius: 14)
        backgroundColor = .purple100
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
