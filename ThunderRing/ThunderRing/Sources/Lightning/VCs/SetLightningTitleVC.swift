//
//  GroupListVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/22.
//

import UIKit

class SetLightningTitleVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupSelectLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameCountLabel: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailCountLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private let groupPickerView = UIPickerView()
    
    // MARK: - Properties
    
    var groupName = ""
    var index = 0
    var groupNames = ["양파링 걸즈", "크롱", "오렌지쥬스", "마법사쥬쥬"]
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .background)
        setStatusBar(.background)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setAction()
        setPickerView()
        setToolbar()
        getNotification()
    }
}

extension SetLightningTitleVC {
    private func initUI() {
        groupNameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        groupNameTextField.setLeftPaddingPoints(15)
        groupNameTextField.setRightPaddingPoints(15)
        groupNameTextField.text = groupNames[index]
        
        nameTextField.delegate = self
        nameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        nameTextField.setLeftPaddingPoints(15)
        
        detailTextView.delegate = self
        detailTextView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        detailTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        nextButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 27, bounds: true)
        nextButton.isEnabled = false
    }
    
    private func setAction() {
        nextButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "SetLigntningDetailVC") as? SetLigntningDetailVC else { return }
            self.nextButton.titleLabel?.textColor = .white
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
    }
    
    private func setPickerView() {
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        
        groupNameTextField.tintColor = .clear
        groupNameTextField.inputView = groupPickerView
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
}

// MARK: - @objc

extension SetLightningTitleVC {
    @objc
    func touchUpDoneButton() {
        NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillHide"), object: nil)
        self.view.endEditing(true)
    }
    
    @objc
    func keyboardWillShow() {
        let topAnchor = self.topConstraint.constant - 120
        
        self.groupSelectLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(topAnchor)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    func keyboardWillHide() {
        let topAnchor = self.topConstraint.constant + 50
        
        self.groupSelectLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(topAnchor)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UITextField Delegate

extension SetLightningTitleVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
        
        nameCountLabel.textColor = .purple100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        
        if nameTextField.hasText {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .purple100
            nextButton.titleLabel?.textColor = .white
            nameCountLabel.textColor = .black
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = .purple100
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            nameCountLabel.textColor = .gray200
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = .gray200
            nextButton.setTitleColor(.white, for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.nameCountLabel.text = String("\(textField.text!.count)/20")
    }
}

extension SetLightningTitleVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        detailTextView.text = ""
        detailTextView.textColor = .black
        detailTextView.layer.borderColor = UIColor.purple100.cgColor
        
        NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillShow"), object: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        detailTextView.textColor = .black
        detailTextView.layer.borderColor = UIColor.gray300.cgColor
        
        if textView.text.isEmpty {
            detailCountLabel.textColor = .gray200
        } else {
            detailCountLabel.textColor = .black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillHide"), object: nil)
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.detailCountLabel.text = String("\(textView.text.count)/100")
    }
}

// MARK: - UIPickerView Protocols

extension SetLightningTitleVC: UIPickerViewDelegate, UIPickerViewDataSource {
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
    }
}
