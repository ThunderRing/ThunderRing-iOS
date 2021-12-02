//
//  SetLigntningDetailVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/22.
//

import UIKit

class SetLigntningDetailVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    @IBOutlet weak var numGuideLabel: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    
    private lazy var datePickerView = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko")
    }
    
    private lazy var timePickerView = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .time
        $0.locale = Locale(identifier: "ko")
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: false, closeBtnIsHidden: false, bgColor: .grayBackground)
        setStatusBar(.grayBackground)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setToolBar()
        setTextField()
        setAction()
        getNotification()
        
        setDatePickerView()
        setTimePickerView()
    }
}

// MARK: - Custom Methods

extension SetLigntningDetailVC {
    private func initUI() {
        view.backgroundColor = .grayBackground
        
        [dateTextField, timeTextField, locationTextField, minTextField, maxTextField].forEach {
            $0?.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.grayStroke.cgColor, cornerRadius: 12, bounds: true)
            $0?.setLeftPaddingPoints(15)
        }
        
        countLabel.isHidden = true
        numGuideLabel.isHidden = true
        
        completeButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 27, bounds: true)
        completeButton.isEnabled = false
        
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateTextField.placeholder = dateFormatter.string(from: nowDate)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "a h:mm"
        timeFormatter.locale = Locale(identifier:"ko")
        timeTextField.placeholder = timeFormatter.string(from: nowDate)
    }
    
    private func setTextField() {
        [dateTextField, timeTextField, locationTextField, minTextField, maxTextField].forEach {
            $0?.delegate = self
            $0?.tintColor = .clear
        }
    }
    
    private func setToolBar() {
        let toolBar = UIToolbar(frame:CGRect(x:0, y:0, width: view.frame.width, height: 44))
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.backgroundColor = .systemGray6
        toolBar.tintColor = .purple100
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(touchUpDoneButton))
        toolBar.items = [flexibleSpace, doneButton]
        
        minTextField.inputAccessoryView = toolBar
        maxTextField.inputAccessoryView = toolBar
    }
    
    private func setDatePickerView() {
        dateTextField.inputView = datePickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = .systemGray6
        toolbar.tintColor = .purple100
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(touchUpDateDoneButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .date
        
        dateTextField.inputAccessoryView = toolbar
    }
    
    private func setTimePickerView() {
        timeTextField.inputView = timePickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = .systemGray6
        toolbar.tintColor = .purple100
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(touchUpTimeDoneButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        timePickerView.preferredDatePickerStyle = .wheels
        timePickerView.datePickerMode = .time
        
        timeTextField.inputAccessoryView = toolbar
    }
    
    private func setAction() {
        completeButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: Const.ViewController.Name.CompleteLightning) else { return }
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
    }
}

// MARK: - @objc

extension SetLigntningDetailVC {
    @objc
    func touchUpDoneButton() {
        NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillHideNotification"), object: nil)
        self.view.endEditing(true)
    }
    
    @objc
    func touchUpDateDoneButton() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.locale = Locale(identifier:"ko")
        dateTextField.text = dateFormatter.string(from: datePickerView.date)
        self.view.endEditing(true)
    }
    
    @objc
    func touchUpTimeDoneButton() {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "a h:mm"
        timeFormatter.locale = Locale(identifier:"ko")
        timeTextField.text = timeFormatter.string(from: timePickerView.date)
        self.view.endEditing(true)
    }
}

// MARK: - TextField Delegate

extension SetLigntningDetailVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateTextField {
            dateTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
        }
        if textField == timeTextField {
            timeTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
        }
        if textField == locationTextField {
            locationTextField.becomeFirstResponder()
            locationTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
            countLabel.isHidden = false
        }
        if textField == minTextField {
            minTextField.becomeFirstResponder()
            numGuideLabel.isHidden = false
            NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        }
        if textField == maxTextField {
            maxTextField.becomeFirstResponder()
            numGuideLabel.isHidden = false
            NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.grayStroke.cgColor, cornerRadius: 12, bounds: true)
        
        if textField == locationTextField {
            countLabel.isHidden = true
        }
        
        if minTextField.hasText && maxTextField.hasText {
            numGuideLabel.isHidden = false
        } else {
            numGuideLabel.isHidden = true
        }
        
        if dateTextField.hasText && timeTextField.hasText && locationTextField.hasText && minTextField.hasText && maxTextField.hasText {
            completeButton.isEnabled = true
            completeButton.backgroundColor = .purple100
            completeButton.titleLabel?.textColor = .white
        } else {
            completeButton.isEnabled = false
            completeButton.backgroundColor = .grayTextNonInput
            completeButton.titleLabel?.textColor = .white
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == locationTextField {
            self.countLabel.text = String("\(textField.text!.count)/20")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

// MARK: - Notification

extension SetLigntningDetailVC {
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name("KeyboardWillHideNotification"), object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        let topAnchor = self.topConstraint.constant - 240
        
        self.dateLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(topAnchor)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        let topAnchor = self.topConstraint.constant + 50
        
        self.dateLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(topAnchor)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

