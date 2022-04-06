//
//  AccountInfoVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/05.
//

import UIKit

import SnapKit
import Then

final class AccountInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "계좌 정보", backButtonIsHidden: false, closeButtonIsHidden: true)
    
    private var bankLabel = UILabel().then {
        $0.text = "은행"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var bankTextField = TDSTextField()
    
    private var accountLabel = UILabel().then {
        $0.text = "계좌 번호"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var accountTextField = TDSTextField()
    
    private var registerButton = TDSButton()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background
        navigationBar.backgroundColor = .background
        
        bankTextField.setPlaceholder(placeholder: "은행명을 입력해주세요")
        accountTextField.setPlaceholder(placeholder: "계좌번호를 입력해주세요")
        
        registerButton.setTitleWithStyle(title: "등록", size: 16)
    }
    
    private func setLayout() {
        view.addSubviews([navigationBar, bankLabel, bankTextField, accountLabel, accountTextField, registerButton])
        
        navigationBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        bankLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(26)
            $0.height.equalTo(23)
        }
        
        bankTextField.snp.makeConstraints {
            $0.top.equalTo(bankLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(50)
        }
        
        accountLabel.snp.makeConstraints {
            $0.top.equalTo(bankTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(26)
            $0.height.equalTo(23)
        }
        
        accountTextField.snp.makeConstraints {
            $0.top.equalTo(accountLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(52)
        }
        
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(
                equalTo: registerButton.bottomAnchor,
                constant: 16
            )
        ])
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        bankTextField.delegate = self
        accountTextField.delegate = self
        
        accountTextField.keyboardType = .numberPad
    }
}

// MARK: - UITextField Delegate

extension AccountInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
        textField.setRightIcon(0, textField.frame.height, UIImage(named: "btnDelete")!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        textField.setRightPaddingPoints(30)
        
        if bankTextField.hasText && accountTextField.hasText {
            registerButton.isActivated = true
        } else {
            registerButton.isActivated = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.setRightPaddingPoints(30)
        return textField.resignFirstResponder()
    }
}
