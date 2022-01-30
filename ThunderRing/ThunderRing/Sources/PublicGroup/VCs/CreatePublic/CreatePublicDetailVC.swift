//
//  CreatePublicVC.swift
//  ThunderRing
//
//  Created by soyeon on 2022/01/28.
//

import UIKit

import SnapKit
import Then

final class CreatePublicDetailVC: UIViewController {
    
    // MARK: - Properties
    
    private lazy var customNavigationBarView = CustomNavigationBar(vc: self, title: "", backBtnIsHidden: false, closeBtnIsHidden: false, bgColor: .background)
    
    private var onelineLabel = UILabel().then {
        $0.text = "한 줄 설명"
        $0.textColor = .gray100
    }
    
    private var onelineTextField = UITextField().then {
        $0.placeholder = "그룹 설명을 입력해주세요"
    }
    
    private var onelineTextCountLabel = UILabel().then {
        $0.text = "0/15"
        $0.textColor = .gray200
    }
    
    private var hashtagLabel = UILabel().then {
        $0.text = "해시태그"
    }
    
    private var hashtagTextField = UITextField().then {
        $0.placeholder = "부지런한 동틀녘"
    }
    
    private var maxCountLabel = UILabel().then {
        $0.text = "최대 정원"
    }
    
    private var maxCountTextField = UITextField().then {
        $0.placeholder = "최대 정원을 입력해주세요"
    }
    
    private var countLabel = UILabel().then {
        $0.text = "명"
        $0.textColor = .gray100
    }
    
    private var warningLabel = UILabel().then {
        $0.text = "*최대 정원은 주최자를 포함이며, 최대 500명 입니다"
        $0.textColor = .purple100
    }
    
    private var nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 16)
        $0.setTitleColor(.gray150, for: .normal)
        $0.backgroundColor = .gray200
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background
        
        [onelineLabel, hashtagLabel, maxCountLabel, countLabel, warningLabel].forEach {
            $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        }
        
        nextButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 26, bounds: true)
    }
    
    private func setupLayout() {
        view.addSubviews([customNavigationBarView,
                          onelineLabel,
                          onelineTextField,
                          onelineTextCountLabel,
                          hashtagLabel,
                          hashtagTextField,
                          maxCountLabel,
                          maxCountTextField,
                          countLabel,
                          warningLabel,
                          nextButton])
        
        customNavigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(57)
        }
        
        onelineLabel.snp.makeConstraints {
            $0.top.equalTo(customNavigationBarView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(25)
        }
        
        onelineTextField.snp.makeConstraints {
            $0.top.equalTo(onelineLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(56)
        }
        
        onelineTextCountLabel.snp.makeConstraints {
            $0.top.equalTo(onelineTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        hashtagLabel.snp.makeConstraints {
            $0.top.equalTo(onelineTextCountLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(25)
        }
        
        hashtagTextField.snp.makeConstraints {
            $0.top.equalTo(hashtagLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(56)
        }
        
        maxCountLabel.snp.makeConstraints {
            $0.top.equalTo(hashtagTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(25)
        }
        
        maxCountTextField.snp.makeConstraints {
            $0.top.equalTo(maxCountLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(61)
            $0.height.equalTo(56)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(maxCountTextField)
            $0.leading.equalTo(maxCountTextField.snp.trailing).offset(18)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(maxCountTextField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(25)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        [onelineTextField, hashtagTextField, maxCountTextField].forEach {
            $0.delegate = self
        }
    }
}

// MARK: - TextField Delegate

extension CreatePublicDetailVC: UITextFieldDelegate {
    
}
