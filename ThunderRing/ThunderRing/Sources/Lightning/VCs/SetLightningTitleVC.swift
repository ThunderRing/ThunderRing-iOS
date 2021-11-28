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
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .grayBackground)
        setStatusBar(.grayBackground)
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
        groupSelectView.initViewBorder(borderWidth: 1, borderColor: UIColor.grayStroke.cgColor, cornerRadius: 12, bounds: true)
        
        groupNameLabel.text = groupName
        
        nameTextField.delegate = self
        nameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.grayStroke.cgColor, cornerRadius: 12, bounds: true)
        nameTextField.setLeftPaddingPoints(15)
        
        detailTextView.delegate = self
        detailTextView.initViewBorder(borderWidth: 1, borderColor: UIColor.grayStroke.cgColor, cornerRadius: 12, bounds: true)
        detailTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        nextButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 27, bounds: true)
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
            self.nextButton.titleLabel?.textColor = .white
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
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
        
        nameCountLabel.textColor = .purple100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.grayStroke.cgColor, cornerRadius: 12, bounds: true)
        
        nameCountLabel.textColor = .black
        
        if nameTextField.hasText {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .purple100
            nextButton.titleLabel?.textColor = .white
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
            detailTextView.layer.borderColor = UIColor.grayStroke.cgColor
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
