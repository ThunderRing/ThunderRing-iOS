//
//  CreatePublicViewController.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/05.
//

import UIKit

import SnapKit
import Then

final class CreatePublicVC: UIViewController {
    
    // MARK: - Properties
    
    private var closeButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnClose"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpCloseButton), for: .touchUpInside)
    }
    
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
        $0.setImage(UIImage(named: "icnEdit"), for: .normal)
    }
    
    private var groupNameLabel = UILabel().then {
        $0.text = "그룹명"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var groupNameTextField = UITextField().then {
        $0.placeholder = "그룹 명을 입력해주세요"
    }
    
    private var groupNameCountLabel = UILabel().then {
        $0.text = "0/10"
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 16)
    }
    
    private var nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.gray150, for: .normal)
        $0.backgroundColor = .gray200
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
        
        profileImageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 20, bounds: true)
        
        groupNameTextField.initViewBorder(borderWidth: 1, borderColor: UIColor.gray200.cgColor, cornerRadius: 10, bounds: true)
        groupNameTextField.setLeftPaddingPoints(15)
    }
    
    private func setupLayout() {
        view.addSubviews([closeButton,
                          profileLabel,
                          profileImageView,
                          profileChangeButton,
                          groupNameLabel,
                          groupNameTextField,
                          groupNameCountLabel,
                          nextButton])
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(9)
            $0.width.height.equalTo(48)
        }
        
        profileLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalTo(closeButton.snp.bottom).offset(24)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(profileLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(120)
        }
        
        profileChangeButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top).offset(88)
            $0.leading.equalTo(profileImageView.snp.leading).offset(88)
            $0.width.height.equalTo(46)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(25)
        }
        
        groupNameTextField.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(56)
        }
        
        groupNameCountLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(52)
        }
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
        if groupNameTextField.hasText {
            let dvc = CreatePublicDetailVC()
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

// MARK: - UITextField Delegate

extension CreatePublicVC: UITextFieldDelegate {
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
        
        if groupNameTextField.hasText {
            groupNameCountLabel.textColor = .black
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = .purple100
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            groupNameCountLabel.textColor = .gray200
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = .gray200
            nextButton.setTitleColor(.white, for: .normal)
        }
    }
}
