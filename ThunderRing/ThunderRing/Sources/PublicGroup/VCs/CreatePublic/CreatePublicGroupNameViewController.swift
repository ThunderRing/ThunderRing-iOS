//
//  CreatePublicViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/02/05.
//

import UIKit

import SnapKit
import Then

final class CreatePublicGroupNameViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "새로운 공개 그룹", backButtonIsHidden: true, closeButtonIsHidden: false)
    
    private var profileLabel = UILabel().then {
        $0.text = "프로필"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var profileImageView = UIImageView().then {
        $0.image = UIImage(named: "imgDog1")
        $0.contentMode = .scaleAspectFit
    }
    
    private var profileChangeButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_plus_purple"), for: .normal)
    }
    
    private var groupNameLabel = UILabel().then {
        $0.text = "그룹 명"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var groupNameTextField = UITextField().then {
        $0.placeholder = "그룹 명을 입력해주세요"
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        $0.tintColor = .purple100
    }
    
    private var groupNameCountLabel = UILabel().then {
        $0.text = "0/10"
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 16)
    }

    private lazy var nextButton = TDSButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isActivated = false
        $0.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        
        nextButton.layer.cornerRadius = 26
        nextButton.layer.masksToBounds = true
        
        profileImageView.makeRounded(cornerRadius: 40)
        
        groupNameTextField.initViewBorder(borderWidth: 1, borderColor: UIColor.gray200.cgColor, cornerRadius: 10, bounds: true)
        groupNameTextField.setLeftPaddingPoints(15)
    }
    
    private func setupLayout() {
        view.addSubviews([navigationBar,
                          profileLabel,
                          profileImageView,
                          profileChangeButton,
                          groupNameLabel,
                          groupNameTextField,
                          groupNameCountLabel,
                          nextButton])
        
        navigationBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        profileLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalTo(navigationBar.snp.bottom).offset(30)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(profileLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(118)
            $0.height.equalTo(120)
        }
        
        profileChangeButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top).offset(88)
            $0.leading.equalTo(profileImageView.snp.leading).offset(88)
            $0.width.height.equalTo(46)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(25)
        }
        
        groupNameTextField.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(50)
        }
        
        groupNameCountLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(52)
        }
        
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(
                equalTo: nextButton.bottomAnchor,
                constant: 16
            )
        ])
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        groupNameTextField.delegate = self
    }
    
    // MARK: - @objc
    
    @objc func touchUpCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func touchUpNextButton() {
        groupNameTextField.resignFirstResponder()
        let dvc = CreatePublicGroupDiscriptionViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    @objc func textFieldDidChange(_ sender: Any) {
        nextButton.isActivated = groupNameTextField.hasText
    }
}

// MARK: - UITextField Delegate

extension CreatePublicGroupNameViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        groupNameCountLabel.text = String("\(textField.text!.count)/10")
        groupNameCountLabel.textColor = .purple100
        
        groupNameTextField.layer.borderColor = UIColor.purple100.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.setRightPaddingPoints(30)
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
    }
}
