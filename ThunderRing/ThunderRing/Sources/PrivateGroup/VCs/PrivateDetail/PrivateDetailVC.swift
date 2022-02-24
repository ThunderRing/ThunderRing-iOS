//
//  PrivateDetailVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/08.
//

import UIKit

import SnapKit
import Then

final class PrivateDetailVC: UIViewController {
    
    // MARK: - Properties
    
    private var navigationView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private var setttingButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnSetting"), for: .normal)
    }
    
    private var closeButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "icnClose"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpCloseButton), for: .touchUpInside)
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
        
        view.addSubviews([navigationView])
        navigationView.addSubviews([setttingButton, closeButton])
    }
    
    private func setLayout() {
        navigationView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(57)
        }
        
        setttingButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(4)
            $0.width.height.equalTo(48)
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(4)
            $0.width.height.equalTo(48)
        }
    }
    
    // MARK: - Custom Method
    
    // MARK: - @objc
    
    @objc func touchUpCloseButton() {
        dismiss(animated: true, completion: nil)
    }
}
