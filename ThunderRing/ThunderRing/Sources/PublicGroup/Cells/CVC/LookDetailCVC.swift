//
//  LookDetailCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/12.
//

import UIKit

class LookDetailCVC: UICollectionViewCell {
    static let identifier = "LookDetailCVC"
    
    // MARK: - UI
    
    private lazy var groupImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 38, bounds: true)
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 18)
        $0.addCharacterSpacing()
    }
    
    private lazy var countImageView = UIImageView().then {
        $0.image = UIImage(named: "icnUser")
    }
    
    private lazy var countLabel = UILabel().then {
        $0.text = "0/0"
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
        $0.addCharacterSpacing()
    }
    
    private lazy var hashTagImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LookDetailCVC {
    private func initUI() {
        self.backgroundColor = .white
        self.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 5, bounds: true)
    }
    
    private func setLayout() {
        self.addSubviews([groupImageView, groupNameLabel, countImageView, countLabel, hashTagImageView])
        
        groupImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
        
        countImageView.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(53)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(7)
            $0.leading.equalTo(countImageView.snp.trailing).offset(3)
        }
        
        hashTagImageView.snp.makeConstraints {
            $0.top.equalTo(countImageView.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
    }
}

extension LookDetailCVC {
    func initCell(group: PublicGroupDataModel) {
        groupImageView.image = UIImage(named: group.groupImage)
        
        groupNameLabel.text = group.groupName
        countLabel.text = "\(group.memberCounts)/\(group.memberTotalCounts!)"
        
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
        hashTagImageView.contentMode = .scaleAspectFit
    }
}
