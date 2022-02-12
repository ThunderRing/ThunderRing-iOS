//
//  GroupListVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/22.
//

import UIKit

final class SetLightningTitleVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupSelectLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameCountLabel: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailCountLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    private let groupPickerView = UIPickerView()
    
    var index = 0
    var groupNames = [String]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bind()
        setAction()
        setToolbar()
        getNotification()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .background)
        setStatusBar(.background)
        
        [groupNameTextField, nameTextField].forEach {
            $0?.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
            $0?.setLeftPaddingPoints(15)
            $0?.setRightPaddingPoints(15)
        }
        
        groupNameTextField.tintColor = .clear
        groupNameTextField.inputView = groupPickerView
        groupNameTextField.text = groupNames[index]
        
        nameTextField.tintColor = .purple100
        
        detailTextView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        detailTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        detailTextView.tintColor = .purple100
        
        nextButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 27, bounds: true)
        nextButton.isEnabled = false
        
        [groupSelectLabel, nameCountLabel, detailCountLabel].forEach {
            $0?.addCharacterSpacing()
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        
        nameTextField.delegate = self
        detailTextView.delegate = self
    }
    
    private func setAction() {
        nextButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "SetLigntningDetailVC") as? SetLigntningDetailVC else { return }
            dvc.groupName = self.groupNameTextField.text
            dvc.lightningName = self.nameTextField.text
            dvc.lightningDescription = self.detailTextView.text
            
            self.nextButton.titleLabel?.textColor = .white
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
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
        groupNameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow() {
        self.view.frame.origin.y = -120
        
        UIView.animate(withDuration: 0.5) {
            self.view.transform = CGAffineTransform.identity
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
        
        UIView.animate(withDuration: 0.5) {
            self.view.transform = CGAffineTransform.identity
        }
    }
}

// MARK: - UITextField Delegate

extension SetLightningTitleVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
        textField.setRightIcon(0, textField.frame.height, UIImage(named: "btnDelete")!)
        
        nameCountLabel.textColor = .purple100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        
        if nameTextField.hasText {
            nameCountLabel.textColor = .black
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = .purple100
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            nameCountLabel.textColor = .gray200
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = .gray200
            nextButton.setTitleColor(.white, for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.setRightPaddingPoints(30)
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.nameCountLabel.text = String("\(textField.text!.count)/15")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 15)
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
        groupNameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
    }
}
