//
//  PrivateGroupCollectionViewCellView.swift
//  ThunderRing
//
//  Created by soyeon on 2022/03/04.
//

import UIKit

import SnapKit
import Then

protocol HomePrivateGroupCollectionViewCellViewDelegate: AnyObject {
    func touchUpEnterButton()
    func touchUpLightningButton()
}

final class HomeMainPrivateGroupCollectionViewCellView: UIView {
    
    // MARK: - Properties
    
    private var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgJuju")
        $0.contentMode = .scaleAspectFill
    }
    
    private var groupNameLabel = UILabel().then {
        $0.text = "그룹이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 17)
    }
    
    private var memberCountLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .gray150
        $0.font = .DINPro(type: .regular, size: 15)
    }
    
    private var descriptionLabel = UILabel().then {
        $0.text = "그룹상세설명"
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private lazy var enterButton = ItemButton(buttonType: .enter).then {
        $0.addTarget(self, action: #selector(touchUpEnterButton), for: .touchUpInside)
    }
    private lazy var lightningButton = ItemButton(buttonType: .lightning).then {
        $0.addTarget(self, action: #selector(touchUpLightningButton), for: .touchUpInside)
    }
    
    weak var delegate: HomePrivateGroupCollectionViewCellViewDelegate?
    
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
        self.backgroundColor = .white
        
        groupImageView.makeRounded(cornerRadius: 28)
    }
    
    private func setLayout() {
        addSubviews([groupImageView,
                          groupNameLabel,
                          descriptionLabel,
                          memberCountLabel,
                          enterButton,
                          lightningButton])
        
        groupImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
            $0.width.equalTo(80)
            $0.height.equalTo(82)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
        }
        
        memberCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(29)
            $0.leading.equalTo(groupNameLabel.snp.trailing).offset(4)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
        }
        
        enterButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.equalTo(groupImageView.snp.trailing).offset(12)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }

        lightningButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.equalTo(enterButton.snp.trailing).offset(7)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpEnterButton() {
        delegate?.touchUpEnterButton()
    }
    
    @objc func touchUpLightningButton() {
        delegate?.touchUpLightningButton()
    }
    
    // MARK: - Public Method
    
    func configCell(group: PrivateGroupDetailData) {
//        guard let image = group.groupImageName else { return }
//        groupImageView.image = UIImage(named: image)
        
        groupNameLabel.text = group.groupName
        
        memberCountLabel.text = "\(group.groupMembers.count)"
        
        descriptionLabel.text = group.groupDescription
    }
}

// MARK: - Button

fileprivate enum ItemButtonType {
    case enter
    case lightning
    
    var title: String {
        switch self {
        case .enter:
            return "그룹상세"
        case .lightning:
            return "번개"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .enter:
            return .purple100
        case .lightning:
            return .white
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .enter:
            return .white
        case .lightning:
            return .purple100
        }
    }
}

fileprivate final class ItemButton: UIButton {
    private lazy var type: ItemButtonType = .enter

    private lazy var textLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        $0.text = type.title
        $0.textColor = type.textColor
        $0.textAlignment = .center
    }

    init(buttonType: ItemButtonType) {
        super.init(frame: .zero)
        self.type = buttonType
        setButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setButton() {
        makeRounded(cornerRadius: 14)
        backgroundColor = type.backgroundColor
        layer.borderWidth = 1
        layer.borderColor = UIColor.purple100.cgColor
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
