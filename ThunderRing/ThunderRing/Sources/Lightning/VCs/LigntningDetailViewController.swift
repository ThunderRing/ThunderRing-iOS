//
//  SetLigntningDetailVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/11/22.
//

import UIKit

import SnapKit

final class LigntningDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    @IBOutlet weak var numGuideLabel: UILabel!
    
    @IBOutlet weak var capacityLabel: UILabel!
    
    private lazy var completeButton = TDSButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isActivated = false
        $0.addTarget(self, action: #selector(touchUpCompleteButton), for: .touchUpInside)
    }
    
    private lazy var datePickerView = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko")
        
        let date = Date()
        $0.minimumDate = date
        
        let maximumDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
        $0.maximumDate = maximumDate
    }
    
    private lazy var timePickerView = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .time
        $0.locale = Locale(identifier: "ko")
    }
    
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy년 MM월 dd일"
        $0.locale = Locale(identifier:"ko")
    }
    
    private let timeFormatter = DateFormatter().then {
        $0.dateFormat = "a h:mm"
        $0.locale = Locale(identifier:"ko")
    }
    
    private let nowDate = Date()
    
    var groupName: String?
    var lightningName: String?
    var lightningDescription: String?
    
    var groupMaxCount: Int = 0
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setToolBar()
        getNotification()
        setDatePickerView()
        setTimePickerView()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .background
        
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: false, closeBtnIsHidden: false, bgColor: .background)
        
        [dateTextField, timeTextField, locationTextField, minTextField, maxTextField].forEach {
            $0?.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
            $0?.setLeftPaddingPoints(15)
            $0?.setRightPaddingPoints(15)
            
            $0?.delegate = self
            $0?.tintColor = .purple100
        }
        
        [dateTextField, timeTextField].forEach {
            $0?.setRightIcon(0, 56, UIImage(named: "btnDown")!)
        }
        
        [countLabel, numGuideLabel].forEach {
            $0?.addCharacterSpacing()
        }
        numGuideLabel.isHidden = true
        
        dateTextField.placeholder = dateFormatter.string(from: nowDate)
        timeTextField.placeholder = timeFormatter.string(from: nowDate)
        
        minTextField.addTarget(self, action: #selector(self.minFieldDidChange(_:)), for: .editingChanged)
        dateTextField.addTarget(self, action: #selector(self.dateFieldDidChange), for: .valueChanged)
        
        maxTextField.placeholder = "최대 \(groupMaxCount)명"
        
        view.addSubview(completeButton)
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(52)
        }
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(
                equalTo: completeButton.bottomAnchor,
                constant: 10
            )
        ])
    }
    
    // MARK: - Custom Method
    
    private func setToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 375, height: 44))
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.backgroundColor = .systemGray6
        toolBar.tintColor = .purple100
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(touchUpDoneButton))
        toolBar.items = [flexibleSpace, doneButton]
        
        minTextField.inputAccessoryView = toolBar
        maxTextField.inputAccessoryView = toolBar
    }
    
    private func setDatePickerView() {
        dateTextField.inputView = datePickerView
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 375, height: 44))
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.backgroundColor = .systemGray6
        toolBar.tintColor = .purple100
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(touchUpDateDoneButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .date
        
        dateTextField.inputAccessoryView = toolBar
    }
    
    private func setTimePickerView() {
        timeTextField.inputView = timePickerView
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 375, height: 44))
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.backgroundColor = .systemGray6
        toolBar.tintColor = .purple100
        
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(touchUpTimeDoneButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        timePickerView.preferredDatePickerStyle = .wheels
        timePickerView.datePickerMode = .time
        
        timeTextField.inputAccessoryView = toolBar
        
        capacityLabel.addCharacterSpacing()
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name("KeyboardWillHideNotification"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func touchUpDoneButton() {
        NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillHideNotification"), object: nil)
        view.endEditing(true)
    }
    
    @objc func touchUpDateDoneButton() {
        dateTextField.text = dateFormatter.string(from: datePickerView.date)
        
        let date = Date()
        if dateFormatter.string(from: datePickerView.date) == dateFormatter.string(from: date) {
            timePickerView.minimumDate = date
        } else {
            timePickerView.minimumDate = .none
        }
        
        view.endEditing(true)
    }
    
    @objc func touchUpTimeDoneButton() {
        timeTextField.text = timeFormatter.string(from: timePickerView.date)
        view.endEditing(true)
    }
    
    @objc func touchUpCompleteButton() {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: Const.ViewController.Name.CompleteLightning) as? CompleteLightningViewController else { return }
        dvc.groupName = self.groupName
        dvc.lightningName = self.lightningName
        dvc.lightningDescription = self.lightningDescription
        dvc.date = self.dateTextField.text
        dvc.time = self.timeTextField.text
        dvc.location = self.locationTextField.text
        
        if let minNumber = self.minTextField.text {
            dvc.minNumber = Int(minNumber)
        }
        
        if let maxNumber = self.maxTextField.text {
            dvc.maxNumber = Int(maxNumber)
        }
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    @objc func minFieldDidChange(_ sender: Any?) {
        if minTextField.text == "0" || minTextField.text == "1" {
            numGuideLabel.isHidden = false
            
            minTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.red.cgColor, cornerRadius: 10, bounds: true)
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        } else {
            numGuideLabel.isHidden = true
            
            minTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 10, bounds: true)
        }
    }
    
    @objc func dateFieldDidChange(_ sender: Any?) {
        dateTextField.text = dateFormatter.string(from: datePickerView.date)
        
        let date = Date()
        if dateFormatter.string(from: datePickerView.date) == dateFormatter.string(from: date) {
            timePickerView.minimumDate = date
        } else {
            timePickerView.minimumDate = .none
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -300
        
        UIView.animate(withDuration: 0.5) {
            self.view.transform = .identity
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
        
        UIView.animate(withDuration: 0.5) {
            self.view.transform = .identity
        }
    }
}

// MARK: - UITextField Delegate

extension LigntningDetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 10, bounds: true)
        
        switch textField {
        case locationTextField:
            countLabel.textColor = .purple100
        case minTextField:
            NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        case maxTextField:
            NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
        
        if textField == locationTextField {
            countLabel.textColor = .gray100
        }
        
        if dateTextField.hasText && timeTextField.hasText && locationTextField.hasText && minTextField.hasText && maxTextField.hasText {
            completeButton.isActivated = true
        } else {
            completeButton.isActivated = false
        }
        
//        if let min = minTextField.text, let max = maxTextField.text {
//            guard let minCount = Int(min) else { return }
//            guard let maxCount = Int(max) else { return }
//
//            if minCount >= maxCount {
//                numGuideLabel.isHidden = false
//
//                minTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.red.cgColor, cornerRadius: 10, bounds: true)
//
//                let generator = UINotificationFeedbackGenerator()
//                generator.notificationOccurred(.error)
//            } else {
//                numGuideLabel.isHidden = true
//
//                minTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
//            }
//        }
        
        if let max = maxTextField.text {
            guard let maxCount = Int(max) else { return }
            
            if maxCount > groupMaxCount {
                numGuideLabel.isHidden = false
                
                maxTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.red.cgColor, cornerRadius: 10, bounds: true)
                
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            } else {
                numGuideLabel.isHidden = true
                
                maxTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == locationTextField {
            countLabel.text = String("\(textField.text!.count)/20")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
