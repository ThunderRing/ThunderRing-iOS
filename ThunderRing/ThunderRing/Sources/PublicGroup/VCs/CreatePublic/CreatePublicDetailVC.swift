//
//  CreatePublicVC.swift
//  ThunderRing
//
//  Created by soyeon on 2022/01/28.
//

import UIKit

import SnapKit
import Then

final class CreatePublicDetailVC: UIViewController {
    
    // MARK: - Properties
    
    private lazy var customNavigationBarView = CustomNavigationBar(vc: self, title: "", backBtnIsHidden: false, closeBtnIsHidden: false, bgColor: .background)
    
    private var onelineLabel = UILabel().then {
        $0.text = "한 줄 설명"
        $0.textColor = .gray100
    }
    
    private var onelineTextField = UITextField().then {
        $0.placeholder = "그룹 설명을 입력해주세요"
    }
    
    private var onelineTextCountLabel = UILabel().then {
        $0.text = "0/15"
        $0.textColor = .gray200
    }
    
    private var hashtagLabel = UILabel().then {
        $0.text = "해시태그"
        $0.textColor = .gray100
    }
    
    private var hashtagTextField = UITextField().then {
        $0.placeholder = "부지런한 동틀녘"
    }
    
    private var maxCountLabel = UILabel().then {
        $0.text = "최대 정원"
        $0.textColor = .gray100
    }
    
    private var maxCountTextField = UITextField().then {
        $0.placeholder = "최대 정원을 입력해주세요"
    }
    
    private var countLabel = UILabel().then {
        $0.text = "명"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }
    
    private var warningLabel = UILabel().then {
        $0.text = "*최대 정원은 주최자를 포함이며, 최대 500명 입니다"
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private var nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 16)
        $0.setTitleColor(.gray150, for: .normal)
        $0.backgroundColor = .gray200
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background
        
        [onelineLabel, hashtagLabel, maxCountLabel].forEach {
            $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
        }
        
        [onelineTextField, hashtagTextField, maxCountTextField].forEach {
            $0.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
            $0.setLeftPaddingPoints(15)
        }
        
        maxCountTextField.keyboardType = .numberPad
        
        nextButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 26, bounds: true)
    }
    
    private func setupLayout() {
        view.addSubviews([customNavigationBarView,
                          onelineLabel,
                          onelineTextField,
                          onelineTextCountLabel,
                          hashtagLabel,
                          hashtagTextField,
                          maxCountLabel,
                          maxCountTextField,
                          countLabel,
                          warningLabel,
                          nextButton])
        
        customNavigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(57)
        }
        
        onelineLabel.snp.makeConstraints {
            $0.top.equalTo(customNavigationBarView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(25)
        }
        
        onelineTextField.snp.makeConstraints {
            $0.top.equalTo(onelineLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(56)
        }
        
        onelineTextCountLabel.snp.makeConstraints {
            $0.top.equalTo(onelineTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        hashtagLabel.snp.makeConstraints {
            $0.top.equalTo(onelineTextCountLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(25)
        }
        
        hashtagTextField.snp.makeConstraints {
            $0.top.equalTo(hashtagLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(56)
        }
        
        maxCountLabel.snp.makeConstraints {
            $0.top.equalTo(hashtagTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(25)
        }
        
        maxCountTextField.snp.makeConstraints {
            $0.top.equalTo(maxCountLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(61)
            $0.height.equalTo(56)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(maxCountTextField)
            $0.leading.equalTo(maxCountTextField.snp.trailing).offset(18)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(maxCountTextField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(25)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        [onelineTextField, hashtagTextField, maxCountTextField].forEach {
            $0.delegate = self
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpNextButton() {
        let dvc = CompleteCreatePublicVC()
        navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - TextField Delegate

extension CreatePublicDetailVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.purple100.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.setRightPaddingPoints(30)
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == onelineTextField {
            guard let text = textField.text else { return }
            onelineTextCountLabel.text = String("\(text.count)/15")
            onelineTextCountLabel.textColor = .black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderColor = UIColor.gray300.cgColor
        
        if textField == maxCountTextField {
            guard let text = maxCountTextField.text else { return }
            guard let textCount = Int(text) else { return }
            if textCount > 500 {
                maxCountTextField.text = "500"
                
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
        }
        
        if onelineTextField.hasText && hashtagTextField.hasText && maxCountTextField.hasText {
            nextButton.isEnabled = true
            
            nextButton.backgroundColor = .purple100
            nextButton.setTitleColor(.white, for: .normal)
        }
    }
}
