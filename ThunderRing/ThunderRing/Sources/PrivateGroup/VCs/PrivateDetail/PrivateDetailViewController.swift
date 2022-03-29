//
//  PrivateDetailVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/12/08.
//

import UIKit

import SnapKit
import Then

final class PrivateDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var navigationView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private lazy var backButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    }
    
    private lazy var setttingButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnSetting"), for: .normal)
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background
        setStatusBar(.background)
    }
    
    private func setLayout() {
        view.addSubviews([navigationView])
        navigationView.addSubviews([backButton, setttingButton])
        
        navigationView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(57)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(4)
            $0.width.height.equalTo(48)
        }
        
        setttingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(4)
            $0.width.height.equalTo(48)
        }
    }
    
    // MARK: - Custom Method
    
    // MARK: - @objc
    
    @objc func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
