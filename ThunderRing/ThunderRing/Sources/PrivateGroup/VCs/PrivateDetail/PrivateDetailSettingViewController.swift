//
//  PrivateDetailSettingViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/30.
//

import UIKit

import SnapKit
import Then

final class PrivateDetailSettingViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "설정", backButtonIsHidden: true, closeButtonIsHidden: false)
    
    private var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgDog1")
    }
    
    private var editButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "icn_plus_purple"), for: .normal)
    }
    
    private var groupNameLabel = UILabel().then {
        $0.text = "양파링걸즈"
        $0.textColor = .gray100
        $0.setTextSpacingBy(value: -0.6)
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "한 줄 설명"
        $0.textColor = .gray100
        $0.setTextSpacingBy(value: -0.6)
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private var subTitleLabel = UILabel().then {
        $0.text = "우리양파링걸즈 킹왕짱"
        $0.textColor = .gray150
        $0.setTextSpacingBy(value: -0.6)
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = .gray350
    }
    
    private var exitButton = UIButton().then {
        $0.setTitle("그룹 나가기", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background
        setStatusBar(.background)
        
        groupImageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 31, bounds: true)
        
        exitButton.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 6, bounds: true)
    }
    
    private func setLayout() {
        view.addSubviews([navigationBar,
                          groupImageView,
                          editButton,
                          groupNameLabel,
                          titleLabel,
                          subTitleLabel,
                          lineView,
                          exitButton])
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        groupImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(86)
            $0.height.equalTo(88)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(88)
            $0.left.equalToSuperview().inset(197)
            $0.width.height.equalTo(48)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(14)
            $0.centerX.equalTo(groupImageView.snp.centerX)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(68)
            $0.leading.equalToSuperview().inset(35)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(35)
        }
        
        lineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.top.equalTo(titleLabel.snp.bottom).offset(17)
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(348)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(43)
        }
    }
    
    // MARK: - Custom Method
}
