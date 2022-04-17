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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background
        
        navigationBar.layer.applyShadow()
    }
    
    private func setLayout() {
        view.addSubviews([navigationBar])
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Custom Method
}
