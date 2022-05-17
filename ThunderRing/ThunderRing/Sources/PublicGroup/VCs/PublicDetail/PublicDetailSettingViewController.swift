//
//  PublicDetailSettingViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/04.
//

import UIKit

import SnapKit
import Then

final class PublicDetailSettingViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "설정", backButtonIsHidden: true, closeButtonIsHidden: false)
    
    private var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "img_groupFace")
    }
    
    private var editButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "icn_plus_purple"), for: .normal)
    }
    
    private var exitButton = UIButton().then {
        $0.setTitle("그룹 나가기", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }
    
    var groupImageName: String = "" {
        didSet {
            groupImageView.image = UIImage(named: groupImageName)
        }
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
        
        exitButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(43)
        }
    }
}
