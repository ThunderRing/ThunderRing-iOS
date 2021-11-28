//
//  SetLigntningDetailVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/22.
//

import UIKit

class SetLigntningDetailVC: UIViewController {

    // MARK: - UI
    
    
    @IBOutlet weak var topAnchor: NSLayoutConstraint!
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
    
    // MARK: - Properties
    
    private var restoreFrameYValue = 0.0
    private let labelTopAnchor: CGFloat = -120
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: false, closeBtnIsHidden: false, bgColor: .grayBackground)
        setStatusBar(.grayBackground)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restoreFrameYValue = self.view.frame.origin.y
        
        initUI()
        setToolBar()
        setTextField()
        setAction()
        getNotification()
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
        timeFormatter.dateFormat = "a H:mm"
        timeFormatter.locale = Locale(identifier:"ko")
        timeTextField.placeholder = timeFormatter.string(from: nowDate)
    }
    
    private func setToolBar() {
        let toolBar = UIToolbar(frame:CGRect(x:0, y:0, width: view.frame.width, height: 44))
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(touchUpDoneButton))
        toolBar.items = [leftSpace, doneButton]
        toolBar.backgroundColor = .systemGray6
        toolBar.tintColor = .purple100
        
        minTextField.inputAccessoryView = toolBar
        maxTextField.inputAccessoryView = toolBar
    }
    
    @objc
    func touchUpDoneButton() {
        NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillHideNotification"), object: nil)
        self.view.endEditing(true)
    }
    
    private func setTextField() {
        [dateTextField, timeTextField, locationTextField, minTextField, maxTextField].forEach {
            $0?.delegate = self
        }
    }
    
    private func setAction() {
        completeButton.addAction(UIAction(handler: { _ in
            // 완료 화면으로 이동
        }), for: .touchUpInside)
    }
}

// MARK: - TextField Delegate

extension SetLigntningDetailVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateTextField {
            dateTextField.resignFirstResponder()
            dateTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
            let dvc = SelectDateVC()
            dvc.modalTransitionStyle = .crossDissolve
            dvc.modalPresentationStyle = .overCurrentContext
            self.present(dvc, animated: true, completion: nil)
        }
        if textField == timeTextField {
            timeTextField.resignFirstResponder()
            timeTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
            let dvc = SelectTimeVC()
            dvc.modalPresentationStyle = .overCurrentContext
            self.present(dvc, animated: true, completion: nil)
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
        NotificationCenter.default.addObserver(self, selector: #selector(selectedDate(_:)), name: NSNotification.Name("SelectedDate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectedTime(_:)), name: NSNotification.Name("SelectedTime"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name("KeyboardWillHideNotification"), object: nil)
    }
        
    @objc
    func selectedDate(_ notification: Notification) {
        dateTextField.resignFirstResponder()
        
        let date = notification.object
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.locale = Locale(identifier:"ko")
        dateTextField.text = dateFormatter.string(from: date as! Date)
        
        dateTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.grayStroke.cgColor, cornerRadius: 12, bounds: true)
    }
    
    @objc
    func selectedTime(_ notification: Notification) {
        timeTextField.resignFirstResponder()
        
        let time = notification.object
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "a H:mm"
        timeFormatter.locale = Locale(identifier:"ko")
        timeTextField.text = timeFormatter.string(from: time as! Date)

        timeTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.grayStroke.cgColor, cornerRadius: 12, bounds: true)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        let topAnchor = self.topAnchor.constant - 580
        
        self.dateLabel.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(topAnchor)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        let topAnchor = self.topAnchor.constant - 310
        
        self.dateLabel.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(topAnchor)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

