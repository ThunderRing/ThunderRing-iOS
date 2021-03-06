//
//  CreateLightningDetailViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/17.
//

import UIKit

import SnapKit
import Then

final class CreateLightningTPOViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "번개 치기", backButtonIsHidden: false, closeButtonIsHidden: false)
    
    private var dateLabel = UILabel().then {
        $0.text = "날짜"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var dateTextField = UITextField().then {
        $0.placeholder = "언제 만나나요?"
    }
    
    private var timeLabel = UILabel().then {
        $0.text = "시간"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var timeTextField = UITextField().then {
        $0.placeholder = "언제 만나나요?"
    }
    
    private var locationLabel = UILabel().then {
        $0.text = "위치"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var locationTextField = UITextField().then {
        $0.placeholder = "어디서 만나나요?"
    }
    
    private var locationCountLabel = UILabel().then {
        $0.text = "0/20"
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 16)
    }
    
    private var totalCountLabel = UILabel().then {
        $0.text = "정원"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var minCountTextField = UITextField().then {
        $0.placeholder = "최소 2명"
        $0.keyboardType = .numberPad
    }
    
    private var waveIconImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_wave")
    }
    
    private var maxCountTextField = UITextField().then {
        $0.keyboardType = .numberPad
    }
    
    private var countWarningLabel = UILabel().then {
        $0.text = "*정원을 확인해주세요"
        $0.setTextSpacingBy(value: -0.6)
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        $0.textColor = .red
        $0.isHidden = true
    }
    
    private var countGuideImageView = UIImageView().then {
        $0.image = UIImage(named: "icn-bubble")
    }
    
    private var countGuideLabel = UILabel().then {
        $0.text = "본인을 포함하며, 그룹원 수를 초과할 수 없어요!"
        $0.textColor = .white
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
        $0.setTextSpacingBy(value: -0.6)
    }

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
        configNavigationUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        setTextField()
        setToolBar()
        getNotification()
        setDatePickerView()
        setTimePickerView()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .background
        setStatusBar(.background)
    }
    
    private func setLayout() {
        view.addSubviews([navigationBar,
                          dateLabel,
                          dateTextField,
                          timeLabel,
                          timeTextField,
                          locationLabel,
                          locationTextField,
                          locationCountLabel,
                          totalCountLabel,
                          minCountTextField,
                          waveIconImageView,
                          maxCountTextField,
                          countWarningLabel,
                          countGuideImageView,
                          completeButton])
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(25)
        }
        
        dateTextField.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(dateTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(25)
        }
        
        timeTextField.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        
        locationLabel.snp.updateConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(286)
            $0.leading.equalToSuperview().inset(25)
        }
        
        locationTextField.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        
        locationCountLabel.snp.makeConstraints {
            $0.top.equalTo(locationTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        totalCountLabel.snp.makeConstraints {
            $0.top.equalTo(locationCountLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(25)
        }
        
        minCountTextField.snp.makeConstraints {
            $0.top.equalTo(totalCountLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(25)
            $0.width.equalTo(135)
            $0.height.equalTo(50)
        }
        
        waveIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(minCountTextField.snp.centerY)
            $0.leading.equalTo(minCountTextField.snp.trailing).offset(18)
            $0.width.equalTo(18)
        }
        
        maxCountTextField.snp.makeConstraints {
            $0.top.equalTo(totalCountLabel.snp.bottom).offset(15)
            $0.trailing.equalToSuperview().inset(25)
            $0.width.equalTo(135)
            $0.height.equalTo(50)
        }
        
        countGuideImageView.snp.makeConstraints {
            $0.centerY.equalTo(totalCountLabel.snp.centerY)
            $0.leading.equalTo(totalCountLabel.snp.trailing).offset(4)
            $0.width.equalTo(240)
            $0.height.equalTo(26)
        }
        
        countGuideImageView.addSubview(countGuideLabel)

        countGuideLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.top.equalToSuperview().inset(5)
        }
        
        countWarningLabel.snp.makeConstraints {
            $0.top.equalTo(minCountTextField.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(25)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(52)
        }
        
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(
                equalTo: completeButton.bottomAnchor,
                constant: 16
            )
        ])
    }
    
    // MARK: - Custom Method
    
    private func setTextField() {
        [dateTextField, timeTextField, locationTextField, minCountTextField, maxCountTextField].forEach {
            $0.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
            $0.setLeftPaddingPoints(14)
            $0.setRightPaddingPoints(14)
            $0.delegate = self
            $0.tintColor = .purple100
        }
        
        [dateTextField, timeTextField].forEach {
            if let image = UIImage(named: "btnDown") {
                $0.setRightIcon(0, 56, image)
            }
        }
        
        dateTextField.addTarget(self, action: #selector(touchUpDateTextField), for: .allTouchEvents)
        timeTextField.addTarget(self, action: #selector(touchUpTimeTextField), for: .allTouchEvents)
        minCountTextField.addTarget(self, action: #selector(minFieldDidChange(_:)), for: .editingChanged)
        maxCountTextField.addTarget(self, action: #selector(maxFieldDidChange(_:)), for: .editingChanged)
        dateTextField.addTarget(self, action: #selector(dateFieldDidChange), for: .valueChanged)
        
        maxCountTextField.placeholder = "최대 \(groupMaxCount)명"
    }
    
    private func setToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 375, height: 44))
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.backgroundColor = .systemGray6
        toolBar.tintColor = .purple100
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(touchUpDoneButton))
        toolBar.items = [flexibleSpace, doneButton]
        
        minCountTextField.inputAccessoryView = toolBar
        maxCountTextField.inputAccessoryView = toolBar
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
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name("KeyboardWillHideNotification"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func touchUpDoneButton() {
        completeButton.isHidden = false
        NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillHideNotification"), object: nil)
        view.endEditing(true)
    }
    
    @objc func touchUpDateDoneButton() {
        completeButton.isHidden = false
        
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
        completeButton.isHidden = false
        
        timeTextField.text = timeFormatter.string(from: timePickerView.date)
        view.endEditing(true)
    }
    
    @objc func touchUpCompleteButton() {
        let dvc = CompleteLightningViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    @objc func minFieldDidChange(_ sender: Any?) {
        if minCountTextField.text == "0" || minCountTextField.text == "1"{
            countWarningLabel.isHidden = false
            
            minCountTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.red.cgColor, cornerRadius: 10, bounds: true)
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        } else {
            countWarningLabel.isHidden = true
            
            minCountTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 10, bounds: true)
        }
    }
    
    @objc func maxFieldDidChange(_ sender: Any?) {
        if let max = maxCountTextField.text {
            guard let maxCount = Int(max) else { return }
            
            if maxCount > groupMaxCount || maxCount < 2 {
                countWarningLabel.isHidden = false
                
                maxCountTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.red.cgColor, cornerRadius: 10, bounds: true)
                
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            } else {
                countWarningLabel.isHidden = true
                
                maxCountTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
            }
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
        dateLabel.isHidden = true
        dateTextField.isHidden = true
        
        timeLabel.isHidden = true
        timeTextField.isHidden = true
        
        locationLabel.snp.updateConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(30)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        dateLabel.isHidden = false
        dateTextField.isHidden = false
        
        timeLabel.isHidden = false
        timeTextField.isHidden = false
        
        locationLabel.snp.updateConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(286)
        }
    }
    
    @objc func touchUpDateTextField() {
        completeButton.isHidden = true
    }
    
    @objc func touchUpTimeTextField() {
        completeButton.isHidden = true
    }
}

// MARK: - UITextField Delegate

extension CreateLightningTPOViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 10, bounds: true)
        
        switch textField {
        case locationTextField:
            locationCountLabel.textColor = .purple100
            NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        case minCountTextField:
            NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        case maxCountTextField:
            NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillShowNotification"), object: nil)
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
        
        if textField == locationTextField {
            locationCountLabel.textColor = .gray100
            NotificationCenter.default.post(name: NSNotification.Name("KeyboardWillHideNotification"), object: nil)
        }
        
        if dateTextField.hasText && timeTextField.hasText && locationTextField.hasText && minCountTextField.hasText && maxCountTextField.hasText {
            completeButton.isActivated = true
        } else {
            completeButton.isActivated = false
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == locationTextField {
            locationCountLabel.text = String("\(textField.text!.count)/20")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
