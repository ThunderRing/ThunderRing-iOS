//
//  CreatePrivateGroupVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/02.
//

import UIKit

class CreatePrivateVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var imageEditButton: UIButton!
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Properties
    
    let imagePicker = UIImagePickerController()
    
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
        setTextField()
        setImagePicker()
    }
}

extension CreatePrivateVC {
    private func initUI() {
        userImageView.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 20, bounds: true)
        
        nextButton.isEnabled = false
        nextButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 27, bounds: true)
        
        groupNameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        groupNameTextField.setLeftPaddingPoints(15)
    }
    
    private func setAction() {
        nextButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "CreatePrivateDetailVC") as? CreatePrivateDetailVC else { return }
            dvc.groupName = self.groupNameTextField.text!
            dvc.groupImage = self.userImageView.image!
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
    }
    
    private func setTextField() {
        groupNameTextField.delegate = self
    }
    
    private func setImagePicker() {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        
        userImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        userImageView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - @objc

extension CreatePrivateVC {
    @objc
    func pickImage() {
        self.present(self.imagePicker, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension CreatePrivateVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
        
        countLabel.textColor = .purple100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        
        if groupNameTextField.hasText {
            countLabel.textColor = .black
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = .purple100
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            groupNameTextField.textColor = .black
            countLabel.textColor = .gray200
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = .gray200
            nextButton.setTitleColor(.white, for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.countLabel.text = String("\(textField.text!.count)/10")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 10)
    }
}

// MARK: - UIImagePickerController Delegate
 
extension CreatePrivateVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        
        self.userImageView.image = newImage
        picker.dismiss(animated: true, completion: nil)
    }
}

