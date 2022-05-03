//
//  CreatePrivateGroupVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/02.
//

import UIKit

import SnapKit
import Then

final class CreatePrivateViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var imageEditButton: UIButton!
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    private lazy var nextButton = TDSButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isActivated = false
        $0.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
    }
    
    let imagePicker = UIImagePickerController()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setTextField()
        setImagePicker()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        setModalNavigationBar(customNavigationBarView: customNavigationBarView, title: "새로운 비공개 그룹", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .background)
        setStatusBar(.background)
        
        userImageView.makeRounded(cornerRadius: 40)
        
        groupNameTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        groupNameTextField.setLeftPaddingPoints(14)
        
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
    
    private func setTextField() {
        groupNameTextField.delegate = self
        
        groupNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        groupNameTextField.setRightPaddingPoints(30)
        groupNameTextField.tintColor = .purple100
    }
    
    private func setImagePicker() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        userImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        userImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - @objc
    
    @objc func pickImage() {
        self.present(self.imagePicker, animated: true)
    }
    
    @objc func touchUpNextButton() {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "CreatePrivateDetailVC") as? CreatePrivateDetailViewController else { return }
        dvc.groupName = self.groupNameTextField.text!
        dvc.groupImage = self.userImageView.image!
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    @objc func textFieldDidChange(_ sender: Any) {
        nextButton.isActivated = groupNameTextField.hasText
    }
}

// MARK: - UITextFieldDelegate

extension CreatePrivateViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
        
        textField.setRightIcon(0, textField.frame.height, UIImage(named: "btnDelete")!)
        
        countLabel.textColor = .purple100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        textField.setRightPaddingPoints(0)
        
        if groupNameTextField.hasText {
            countLabel.textColor = .black
            
            nextButton.isActivated = true
        } else {
            groupNameTextField.textColor = .black
            countLabel.textColor = .gray200
            
            nextButton.isActivated = false
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
 
extension CreatePrivateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

