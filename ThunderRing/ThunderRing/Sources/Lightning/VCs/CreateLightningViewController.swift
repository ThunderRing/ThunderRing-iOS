//
//  CreateLightningViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/17.
//

import UIKit

import SnapKit
import Then

final class CreateLightningViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "번개 치기", backButtonIsHidden: true, closeButtonIsHidden: false)
    
    private var groupNameLabel = UILabel().then {
        $0.text = "그룹 선택"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private lazy var groupNameTextField = UITextField().then {
        $0.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        $0.setLeftPaddingPoints(14)
        $0.backgroundColor = .white
        $0.tintColor = .clear
        $0.inputView = groupPickerView
        $0.text = groupNames[index]
        $0.addTarget(self, action: #selector(touchUpNameTextField), for: .allTouchEvents)
    }
    
    private let groupPickerView = UIPickerView()
    
    private lazy var lightningNameLabel = UILabel().then {
        $0.text = "번개 이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private lazy var lightningNameTextField = UITextField().then {
        $0.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        $0.setLeftPaddingPoints(14)
        $0.backgroundColor = .white
        $0.tintColor = .purple100
        $0.placeholder = "어떤 주제로 번개를 치나요?"
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }
    
    private var lightningNameCountLabel = UILabel().then {
        $0.text = "0/10"
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 16)
    }
    
    private var detailTextView = UITextView().then {
        $0.text = "세부 전달사항을 입력해주세요 (선택)"
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        $0.textColor = .gray200
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        $0.textContainerInset = UIEdgeInsets(top: 11, left: 13, bottom: 11, right: 13)
        $0.tintColor = .purple100
        $0.backgroundColor = .white
    }
    
    private var detailCountLabel = UILabel().then {
        $0.text = "0/120"
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 16)
    }
    
    private lazy var nextButton = TDSButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isActivated = false
        $0.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
    }
    
    private lazy var iconImageView = UIImageView().then {
        $0.image = UIImage(named: "btnDown")
    }
    
    var index = 0
    var groupNames = [String]()
    var groupMaxCounts = [Int]()
    var groupMaxCount: Int = 0
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        bind()
        setToolbar()
        getNotification()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        setStatusBar(.background)
        view.backgroundColor = .background
    }
    
    private func setLayout() {
        view.addSubviews([navigationBar, groupNameLabel, groupNameTextField, lightningNameLabel, lightningNameTextField, lightningNameCountLabel, detailTextView, detailCountLabel, nextButton])
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(25)
        }
        
        groupNameTextField.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        
        groupNameTextField.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(277)
            $0.top.bottom.equalToSuperview().inset(1)
            $0.width.height.equalTo(48)
        }
        
        lightningNameLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(158)
            $0.leading.equalToSuperview().inset(25)
        }
        
        lightningNameTextField.snp.makeConstraints {
            $0.top.equalTo(lightningNameLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        
        lightningNameCountLabel.snp.makeConstraints {
            $0.top.equalTo(lightningNameTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        detailTextView.snp.makeConstraints {
            $0.top.equalTo(lightningNameCountLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(146)
        }
        
        detailCountLabel.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(4)
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
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        
        lightningNameTextField.delegate = self
        
        detailTextView.delegate = self
    }
    
    private func setToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.tintColor = .purple100
        
        let button = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(touchUpDoneButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexibleSpace, button], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        groupNameTextField.inputAccessoryView = toolBar
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name("KeyboardWillShow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name("KeyboardWillHide"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func touchUpDoneButton() {
        NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillHide"), object: nil)
        groupNameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
        nextButton.isHidden = false
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow() {
        groupNameLabel.isHidden = true
        
        lightningNameLabel.snp.updateConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(30)
        }
    }
    
    @objc func keyboardWillHide() {
        groupNameLabel.isHidden = false
        
        lightningNameLabel.snp.updateConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(158)
        }
    }
    
    @objc func touchUpNextButton() {
        if groupNameTextField.hasText {
            let vc = CreateLightningTPOViewController()
            
            vc.groupName = self.groupNameTextField.text
            vc.lightningName = self.lightningNameLabel.text
            vc.lightningDescription = self.detailTextView.text
            vc.groupMaxCount = self.groupMaxCounts[index]
            
            nextButton.titleLabel?.textColor = .white
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func touchUpNameTextField() {
        nextButton.isHidden = true
    }
}

// MARK: - UITextField Delegate

extension CreateLightningViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 10, bounds: true)
        textField.setRightIcon(0, textField.frame.height, UIImage(named: "btnDelete")!)
        lightningNameCountLabel.textColor = .purple100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
        
        if lightningNameTextField.hasText {
            lightningNameCountLabel.textColor = .gray100
            nextButton.isActivated = true
        } else {
            lightningNameCountLabel.textColor = .gray200
            nextButton.isActivated = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.setRightPaddingPoints(30)
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.lightningNameCountLabel.text = String("\(textField.text!.count)/10")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 10)
    }
}

// MARK: - UITextView Delegate

extension CreateLightningViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !detailTextView.text.isEmpty {
            detailTextView.text = ""
        }
        detailTextView.textColor = .black
        detailTextView.layer.borderColor = UIColor.purple100.cgColor
        
        detailCountLabel.textColor = .purple100
        
        NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillShow"), object: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        detailTextView.textColor = .black
        detailTextView.layer.borderColor = UIColor.gray300.cgColor
        
        if textView.text.isEmpty {
            detailTextView.text = "세부 전달사항을 입력해주세요 (선택)"
            detailTextView.textColor = .gray200
            
            detailCountLabel.textColor = .gray200
        } else {
            detailCountLabel.textColor = .gray100
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillHide"), object: nil)
            textView.resignFirstResponder()
        }
        
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        
        return newLength <= 120
    }
    
    func textViewDidChange(_ textView: UITextView) {
        detailCountLabel.text = String("\(textView.text.count)/120")
    }
}

// MARK: - UIPickerView Protocols

extension CreateLightningViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groupNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        groupNameTextField.text = groupNames[row]
        groupMaxCount = groupMaxCounts[row]
        groupNameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
    }
}
