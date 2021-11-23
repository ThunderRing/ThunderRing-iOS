//
//  GroupListVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/22.
//

import UIKit

class SetLightningTitleVC: UIViewController {

    // MARK: - IB Outlets
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var groupSelectView: UIView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameCountLabel: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailCountLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Properties
    
    var groupName = ""
    private var restoreFrameYValue = 0.0
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: false, closeBtnIsHidden: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restoreFrameYValue = self.view.frame.origin.y
        
        initUI()
        getNotification()
        getAction()
    }
}

extension SetLightningTitleVC {
    private func initUI() {
        groupSelectView.layer.backgroundColor = UIColor.white.cgColor
        groupSelectView.layer.borderWidth = 1
        groupSelectView.layer.borderColor = UIColor.lightGray.cgColor
        groupSelectView.layer.cornerRadius = 12
        groupSelectView.layer.masksToBounds = true
        
        groupNameLabel.text = groupName
        
        nameTextField.delegate = self
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.layer.cornerRadius = 12
        nameTextField.layer.masksToBounds = true
        nameTextField.setLeftPaddingPoints(15)
        
        detailTextView.delegate = self
        detailTextView.layer.borderWidth = 1
        detailTextView.layer.borderColor = UIColor.lightGray.cgColor
        detailTextView.layer.cornerRadius = 12
        detailTextView.layer.masksToBounds = true
        detailTextView.textContainer.lineFragmentPadding = 18
        
        nextButton.backgroundColor = .lightGray
        nextButton.setTitleColor(.gray, for: .normal)
        nextButton.layer.cornerRadius = 12
        nextButton.layer.masksToBounds = true
        nextButton.isEnabled = false
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func getAction() {
        nextButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "SetLigntningDetailVC") as? SetLigntningDetailVC else { return }
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
    }
}

// MARK: - @objc

extension SetLightningTitleVC {
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if self.view.frame.origin.y == restoreFrameYValue {
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardHeight = keyboardFrame.cgRectValue.height
                self.view.frame.origin.y -= keyboardHeight
            }
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        if self.view.frame.origin.y != restoreFrameYValue {
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardHeight = keyboardFrame.cgRectValue.height
                self.view.frame.origin.y += keyboardHeight
            }
        }
    }
}



// MARK: - UITextField Delegate

extension SetLightningTitleVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.purple100.cgColor
        textField.layer.cornerRadius = 12
        
        nameCountLabel.textColor = .purple100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 12
        
        nameCountLabel.textColor = .black
        
        if nameTextField.hasText {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .purple100
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
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            detailTextView.text = ""
        } else {
            detailTextView.textColor = .black
            detailTextView.layer.borderColor = UIColor.purple100.cgColor
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.detailCountLabel.text = String("\(textView.text.count)/100")
    }
}
