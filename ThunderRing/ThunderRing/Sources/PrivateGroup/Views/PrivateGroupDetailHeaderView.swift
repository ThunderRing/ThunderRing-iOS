//
//  GroupDetailHeaderView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/30.
//

import UIKit

import SnapKit
import Then

protocol PrivateGroupDetailHeaderViewDelegate: AnyObject {
    func touchUpInviteButton()
    func touchUpShareButton()
}

final class PrivateGroupDetailHeaderView: UIView {
    // MARK: - Properties
    
    private lazy var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgDog1")
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.text = "그룹이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 20)
    }
    
    private lazy var groupDescriptionLabel = UILabel().then {
        $0.text = "그룹상세설명"
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private lazy var buttonBackView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var inviteButton = UIButton().then {
        $0.setTitle("그룹원 초대", for: .normal)
        $0.setTitleColor(.gray100, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 14)
        $0.addTarget(self, action: #selector(touchUpInviteButton), for: .touchUpInside)
    }
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = .gray300
    }
    
    private lazy var shareButton = UIButton().then {
        $0.setTitle("초대 링크 공유", for: .normal)
        $0.setTitleColor(.purple100, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 14)
        $0.addTarget(self, action: #selector(touchUpShareButton), for: .touchUpInside)
    }
    
    weak var delegate: PrivateGroupDetailHeaderViewDelegate?
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func configUI() {
        backgroundColor = .background
        
        buttonBackView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 10, bounds: true)
        
        groupImageView.makeRounded(cornerRadius: 33)
    }
    
    private func setLayout() {
        addSubviews([groupImageView, groupNameLabel, groupDescriptionLabel, buttonBackView])
        buttonBackView.addSubviews([inviteButton, lineView, shareButton])
        
        groupImageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.equalTo(98)
            $0.height.equalTo(100)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(27)
            $0.centerX.equalToSuperview()
        }
        
        groupDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
        
        buttonBackView.snp.makeConstraints {
            $0.top.equalTo(groupDescriptionLabel.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(61)
            $0.height.equalTo(44)
        }
        
        inviteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(31)
        }
        
        lineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(23)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpInviteButton() {
        delegate?.touchUpInviteButton()
    }
    
    @objc func touchUpShareButton() {
        delegate?.touchUpShareButton()
    }
}

