//
//  CreatePublicVC.swift
//  ThunderRing
//
//  Created by soyeon on 2022/01/28.
//

import UIKit

import SnapKit
import Then

final class CreatePublicGroupDiscriptionViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "새로운 공개 그룹", backButtonIsHidden: false, closeButtonIsHidden: false)
    
    private var onelineLabel = UILabel().then {
        $0.text = "한 줄 설명"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
        $0.setTextSpacingBy(value: -0.6)
    }
    
    private lazy var onelineTextField = UITextField().then {
        $0.placeholder = "그룹 설명을 입력해주세요"
        $0.tintColor = .purple100
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private var onelineTextCountLabel = UILabel().then {
        $0.text = "0/20"
        $0.textColor = .gray100
        $0.font = .DINPro(type: .regular, size: 16)
    }
    
    private var maxCountLabel = UILabel().then {
        $0.text = "최대 정원"
        $0.textColor = .gray100
    }
    
    private lazy var bubbleImageView = UIImageView().then {
        $0.image = UIImage(named: "icn-bubble")
    }
    
    private lazy var bubbleLabel = UILabel().then {
        $0.text = "본인을 포함하며, 최대 300명까지에요!"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .white
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private lazy var maxCountTextField = UITextField().then {
        $0.placeholder = "최대 정원을 입력해주세요"
        $0.tintColor = .purple100
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private var countLabel = UILabel().then {
        $0.text = "명"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }
    
    private var warningLabel = UILabel().then {
        $0.text = "*최대 정원을 확인해주세요"
        $0.textColor = .red
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        $0.isHidden = true
    }
    
    private lazy var nextButton = TDSButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isActivated = false
        $0.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        onelineTextField.setRightPaddingPoints(30)
        maxCountTextField.setRightPaddingPoints(30)
        
        view.endEditing(true)
    }
    
    // MARK: - InitUI
    
    private func configNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func configUI() {
        view.backgroundColor = .background
        
        [onelineLabel, maxCountLabel].forEach {
            $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
        }
        
        [onelineTextField, maxCountTextField].forEach {
            $0.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
            $0.setLeftPaddingPoints(15)
        }
        
        maxCountTextField.keyboardType = .numberPad
    }
    
    private func setupLayout() {
        view.addSubviews([navigationBar,
                          onelineLabel,
                          onelineTextField,
                          onelineTextCountLabel,
                          maxCountLabel,
                          maxCountTextField,
                          bubbleImageView,
                          countLabel,
                          warningLabel,
                          nextButton])
        bubbleImageView.addSubview(bubbleLabel)
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        onelineLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(25)
        }
        
        onelineTextField.snp.makeConstraints {
            $0.top.equalTo(onelineLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(50)
        }
        
        onelineTextCountLabel.snp.makeConstraints {
            $0.top.equalTo(onelineTextField.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        maxCountLabel.snp.makeConstraints {
            $0.top.equalTo(onelineTextCountLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(25)
        }
        
        maxCountTextField.snp.makeConstraints {
            $0.top.equalTo(maxCountLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(61)
            $0.height.equalTo(50)
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.leading.equalTo(maxCountLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(maxCountLabel.snp.centerY)
            $0.width.equalTo(202)
            $0.height.equalTo(26)
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(17)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(maxCountTextField)
            $0.leading.equalTo(maxCountTextField.snp.trailing).offset(17)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(maxCountTextField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(24)
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
        [onelineTextField, maxCountTextField].forEach {
            $0.delegate = self
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpNextButton() {
        let dvc = CreatePublicGroupTagViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    @objc func textFieldDidChange(_ sender: Any) {
        if onelineTextField.hasText && maxCountTextField.hasText {
            nextButton.isActivated = true
        }
        
        guard let text = maxCountTextField.text else { return }
        guard let textCount = Int(text) else { return }
        
        if textCount > 300 || textCount < 2 {
            maxCountTextField.layer.borderColor = UIColor.red.cgColor
            warningLabel.isHidden = false
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        } else {
            maxCountTextField.layer.borderColor = UIColor.purple100.cgColor
            warningLabel.isHidden = true
        }
    }
}

// MARK: - TextField Delegate

extension CreatePublicGroupDiscriptionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.purple100.cgColor
        textField.setRightIcon(0, textField.frame.height, UIImage(named: "btnDelete")!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.setRightPaddingPoints(30)
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == onelineTextField {
            guard let text = textField.text else { return }
            onelineTextCountLabel.text = String("\(text.count)/20")
            onelineTextCountLabel.textColor = .black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderColor = UIColor.gray300.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == onelineTextField {
            let newLength = (textField.text?.count)! + string.count - range.length
            return !(newLength > 20)
        }
        return true
    }
}
