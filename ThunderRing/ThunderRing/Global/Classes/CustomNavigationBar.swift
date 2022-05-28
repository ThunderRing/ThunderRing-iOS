//
//  CustomNavi.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

import SnapKit
import Then

class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btnBack"), for: .normal)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .SpoqaHanSansNeo(type: .medium, size: 20)
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icnClose"), for: .normal)
        return button
    }()
    
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
            $0.leading.equalToSuperview().inset(25)
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(9)
            $0.width.height.equalTo(48)
            $0.bottom.equalToSuperview().inset(1)
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
    
    // MARK: - Public Method
    
    public func setTitle(title: String) {
        self.titleLabel.text = title
    }
}
