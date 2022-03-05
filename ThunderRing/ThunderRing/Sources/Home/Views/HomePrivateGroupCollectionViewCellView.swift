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

final class HomePrivateGroupCollectionViewCellView: UIView {
    
    // MARK: - Properties
    
    private lazy var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgJuju")
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "그룹이름"
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 17)
    }
    
    private lazy var memberCountLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.text = "그룹상세설명"
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private lazy var enterButton = ItemButton(buttonType: .enter)
    private lazy var lightningButton = ItemButton(buttonType: .lightning)
    
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
        self.backgroundColor = .background
        addSubviews([groupImageView, titleLabel, subTitleLabel, enterButton, lightningButton])
        
        groupImageView.makeRounded(cornerRadius: 25)
    }
    
    // FIXME: - 레이아웃 값 수정
    private func setLayout() {
        groupImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalTo(groupImageView.snp.trailing).offset(19)
        }
        
        memberCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(groupImageView.snp.trailing).offset(19)
        }
        
        enterButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(groupImageView.snp.trailing).offset(19)
        }
        
        lightningButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(enterButton.snp.trailing).offset(7)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpEnterButton() {
        delegate?.touchUpEnterButton()
    }
    
    @objc func touchUpLightningButton() {
        delegate?.touchUpLightningButton()
    }
}

// MARK: - Button

fileprivate enum ItemButtonType {
    case enter
    case lightning
    
    var title: String {
        switch self {
        case .enter:
            return "입장"
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
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
        $0.text = type.title
        $0.textColor = type.textColor
        $0.backgroundColor = type.backgroundColor
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
        self.makeRounded(cornerRadius: 14)
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
