//
//  GroupListVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/11/22.
//

import UIKit

import SnapKit

final class LightningTitleViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupSelectLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameCountLabel: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailCountLabel: UILabel!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    private let groupPickerView = UIPickerView()
    
    private lazy var nextButton = TDSButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isActivated = false
        $0.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
    }
    
    var index = 0
    var groupNames = [String]()
    var groupMaxCounts = [Int]()
    var groupMaxCount: Int = 0
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bind()
        setToolbar()
        getNotification()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .background)
        setStatusBar(.background)
        
        groupNameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        groupNameTextField.setLeftPaddingPoints(14)
        groupNameTextField.tintColor = .clear
        groupNameTextField.inputView = groupPickerView
        groupNameTextField.text = groupNames[index]
        
        nameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        nameTextField.setLeftPaddingPoints(14)
        nameTextField.tintColor = .purple100
        
        detailTextView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        detailTextView.textContainerInset = UIEdgeInsets(top: 12, left: 15, bottom: 15, right: 15)
        detailTextView.tintColor = .purple100
        
        view.addSubview(nextButton)
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
        
        nameTextField.delegate = self
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
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow() {
        view.frame.origin.y = -120
        
        UIView.animate(withDuration: 0.5) {
            self.view.transform = CGAffineTransform.identity
        }
    }
    
    @objc func keyboardWillHide() {
        view.frame.origin.y = 0
        
        UIView.animate(withDuration: 0.5) {
            self.view.transform = CGAffineTransform.identity
        }
    }
    
    @objc func touchUpNextButton() {
        if groupNameTextField.hasText {
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "LigntningDetailViewController") as? LigntningDetailViewController else { return }
            dvc.groupName = self.groupNameTextField.text
            dvc.lightningName = self.nameTextField.text
            dvc.lightningDescription = self.detailTextView.text
            dvc.groupMaxCount = self.groupMaxCount
            
            nextButton.titleLabel?.textColor = .white
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

// MARK: - UITextField Delegate

extension LightningTitleViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 10, bounds: true)
        textField.setRightIcon(0, textField.frame.height, UIImage(named: "btnDelete")!)
        
        nameCountLabel.textColor = .purple100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
        
        if nameTextField.hasText {
            nameCountLabel.textColor = .black
            nextButton.isActivated = true
        } else {
            nameCountLabel.textColor = .gray200
            nextButton.isActivated = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.setRightPaddingPoints(30)
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.nameCountLabel.text = String("\(textField.text!.count)/10")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 10)
    }
}

extension LightningTitleViewController: UITextViewDelegate {
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
        detailCountLabel.text = String("\(textView.text.count)/100")
    }
}

// MARK: - UIPickerView Protocols

extension LightningTitleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
