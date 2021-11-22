//
//  SetLigntningDetailVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/22.
//

import UIKit

class SetLigntningDetailVC: UIViewController {

    // MARK: - IB Outlets
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: false, closeBtnIsHidden: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setTextField()
        setAction()
        getNotification()
    }
}

extension SetLigntningDetailVC {
    private func initUI() {
        
    }
    
    private func setTextField() {
        dateTextField.delegate = self
        timeTextField.delegate = self
        locationTextField.delegate = self
    }
    
    private func setAction() {
        completeButton.addAction(UIAction(handler: { _ in
            // 완료 화면으로 이동
        }), for: .touchUpInside)
    }
}

extension SetLigntningDetailVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.purple100.cgColor
        
        if textField == dateTextField {
            dateTextField.resignFirstResponder()
            let dvc = SelectDateVC()
            dvc.modalPresentationStyle = .overCurrentContext
            self.present(dvc, animated: true, completion: nil)
        }
        if textField == timeTextField {
            timeTextField.resignFirstResponder()
        }
        if textField == locationTextField {
            locationTextField.becomeFirstResponder()
        }
    }
}

extension SetLigntningDetailVC {
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(selectedDate(_:)), name: NSNotification.Name("SelectedDate"), object: nil)
    }
        
    @objc
    func selectedDate(_ notification: Notification) {
        dateTextField.resignFirstResponder()
        dateTextField.text = "2021.11.23"
        dateTextField.layer.borderWidth = 1
        dateTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
}
