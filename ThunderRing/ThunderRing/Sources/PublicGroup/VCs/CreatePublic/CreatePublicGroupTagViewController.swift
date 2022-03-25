//
//  CreatePublicSubdetailViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/23.
//

import UIKit

import SnapKit
import Then

final class CreatePublicGroupTagViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "새로운 공개 그룹", backButtonIsHidden: false, closeButtonIsHidden: false)
    
    private var groupTendencyLabel = UILabel().then {
        $0.text = "그룹 성향"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var groupTendencyInfoImageView = UIImageView().then {
        $0.image = UIImage(named: "btn_info")
    }
    
    private var groupTendencyDiscriptionLabel = UILabel().then {
        $0.text = "성향은 우리 그룹의 특징을 나타내요"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private var groupTendencyTextField = UITextField().then {
        $0.placeholder = "부지런한 동틀녘"
    }
    
    private var tagLabel = UILabel().then {
        $0.text = "해시태그"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var tagDiscriptionLabel = UILabel().then {
        $0.text = "태그는 그룹 검색 시 사용돼요"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private var groupTagTextField = UITextField().then {
        $0.placeholder = "#태그 #태그 #태그"
    }
    
    private lazy var tagWarningLabel = UILabel().then {
        $0.text = "3개 이하로 입력해주세요"
        $0.textColor = .red
        $0.isHidden = true
    }
    
    private lazy var nextButton = TDSButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isActivated = false
        $0.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
    }
    private let groupTendencyPickerView = UIPickerView()
    private var index = 0
    private var groupTendency = ["부지런한 동틀녘", "사근한 오전", "북적이는 오후", "포근한 해질녘", "감성적인 새벽녘"]
    
    private lazy var tagCount: Int = 0
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        setToolbar()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        
        [groupTendencyTextField, groupTagTextField].forEach {
            $0.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
            $0.setLeftPaddingPoints(15)
        }
        
        groupTendencyTextField.tintColor = .clear
        groupTendencyTextField.inputView = groupTendencyPickerView
        groupTendencyTextField.text = groupTendency[index]
    }
    
    private func setLayout() {
        view.addSubviews([navigationBar,
                          groupTendencyLabel,
                          groupTendencyInfoImageView,
                          groupTendencyDiscriptionLabel,
                          groupTendencyTextField,
                          tagLabel,
                          tagDiscriptionLabel,
                          groupTagTextField,
                          tagWarningLabel,
                          nextButton])
        
        navigationBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        groupTendencyLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(25)
        }
        
        groupTendencyInfoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(85)
            $0.top.equalTo(navigationBar.snp.bottom).offset(21)
            $0.width.height.equalTo(40)
        }
        
        groupTendencyDiscriptionLabel.snp.makeConstraints {
            $0.top.equalTo(groupTendencyLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(25)
        }
        
        groupTendencyTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.top.equalTo(groupTendencyDiscriptionLabel.snp.bottom).offset(14)
            $0.height.equalTo(50)
        }
        
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(groupTendencyTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(25)
        }
        
        tagDiscriptionLabel.snp.makeConstraints {
            $0.top.equalTo(tagLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(25)
        }
        
        groupTagTextField.snp.makeConstraints {
            $0.top.equalTo(tagDiscriptionLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(50)
        }
        
        tagWarningLabel.snp.makeConstraints {
            $0.top.equalTo(groupTagTextField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(25)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(52)
        }
        
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(
                equalTo: nextButton.bottomAnchor,
                constant: 10
            )
        ])
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        groupTendencyPickerView.delegate = self
        groupTendencyPickerView.dataSource = self
        
        groupTagTextField.delegate = self
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
        
        groupTendencyTextField.inputAccessoryView = toolBar
    }
    
    // MARK: - @objc
    
    @objc func touchUpNextButton() {
        let dvc = CompleteCreatePublicViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    @objc func touchUpDoneButton() {
        groupTendencyTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        self.view.endEditing(true)
    }
}

// MARK: - UIPickerView Protocols

extension CreatePublicGroupTagViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupTendency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groupTendency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        groupTendencyTextField.text = groupTendency[row]
        groupTendencyTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
    }
}

// MARK: - TextField Delegate

extension CreatePublicGroupTagViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.purple100.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.setRightPaddingPoints(30)
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderColor = UIColor.gray300.cgColor

        if groupTendencyTextField.hasText && groupTagTextField.hasText {
            nextButton.isActivated = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        guard let lastChar = str.last else { return true }
        if lastChar == " " {
            guard let text = groupTagTextField.text else { return true }
            let firstTagView = TagView(groupTag: text)
            groupTagTextField.addSubview(firstTagView)
            firstTagView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(13)
                $0.top.bottom.equalToSuperview().inset(13)
                $0.width.equalTo(74)
            }
            groupTagTextField.text = ""
        }
        return true
    }
}

fileprivate final class TagView: UIView {
    
    // MARK: - Properties
    
    private lazy var groupTagLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }
    
    private lazy var cancelButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: ""), for: .normal)
    }
    
    var groupTag: String = "" {
        didSet {
            groupTagLabel.text = groupTag
        }
    }
    
    // MARK: - Initialzier
    
    init(groupTag: String) {
        super.init(frame: .zero)
        self.groupTag = groupTag
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - init UI
    
    private func setView() {
        backgroundColor = .gray350
        addSubviews([groupTagLabel, cancelButton])
        groupTagLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.top.bottom.equalToSuperview().inset(5)
        }
        cancelButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10.5)
            $0.top.bottom.equalToSuperview().inset(7)
        }
    }
}
