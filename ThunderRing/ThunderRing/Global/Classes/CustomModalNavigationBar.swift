//
//  CustomModalNavigationBar.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/12.
//

import UIKit

import SnapKit
import Then

final class CustomModalNavigationBar: UIView {
    
    // MARK: - Properties
    
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
    }
    
    private var titleLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "icnClose"), for: .normal)
    }
    
    // MARK: - Initializer
    
    init(vc: UIViewController, title: String, backBtnIsHidden: Bool, closeBtnIsHidden: Bool, bgColor: UIColor) {
        super.init(frame: .zero)
        
        initUI(bgColor: bgColor)
        initLayout()
        initAction(vc: vc)
        initTitle(title: title)
        initBackButton(backBtnIsHidden: backBtnIsHidden)
        initCloseButton(closeBtnIsHidden: closeBtnIsHidden)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func initUI(bgColor: UIColor) {
        self.backgroundColor = bgColor
    }
    
    private func initLayout() {
        addSubviews([backButton, titleLabel, closeButton])
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(7)
            $0.width.height.equalTo(48)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(9)
            $0.width.height.equalTo(48)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    private func initTitle(title: String) {
        self.titleLabel.text = title
    }
    
    private func initAction(vc: UIViewController) {
        let backAction = UIAction { _ in
            vc.navigationController?.popViewController(animated: true)
        }
        backButton.addAction(backAction, for: .touchUpInside)
        
        let closeAction = UIAction { _ in
            vc.dismiss(animated: true, completion: nil)
        }
        closeButton.addAction(closeAction, for: .touchUpInside)
    }
    
    private func initBackButton(backBtnIsHidden: Bool) {
        backButton.isHidden = backBtnIsHidden
    }
    
    private func initCloseButton(closeBtnIsHidden: Bool) {
        closeButton.isHidden = closeBtnIsHidden
    }
    
    // MARK: - Custom Method
    
    internal func setTitle(title: String) {
        self.titleLabel.text = title
    }
}

