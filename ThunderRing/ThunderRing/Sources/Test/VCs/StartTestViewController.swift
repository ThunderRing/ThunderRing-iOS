//
//  StartTestViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/18.
//

import UIKit

import SnapKit
import Then

class StartTestViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var closeButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnClose"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpCloseButton), for: .touchUpInside)
    }
    
    private var typoImageView = UIImageView().then {
        $0.image = UIImage(named: "text_testStart")
    }
    
    private var contentLabel = UILabel().then {
        $0.text = "이지원님의 성향을 분석해볼게요\n그룹 번개 케미, 나는 어떤 유형일까?"
        $0.textAlignment = .center
        $0.setTextSpacingBy(value: -0.6)
        $0.numberOfLines = 2
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 17)
    }
    
    private var graphicImageView = UIImageView().then {
        $0.image = UIImage(named: "img_testStart")
    }
    
    private lazy var testButton = TDSButton().then {
        $0.setTitleWithStyle(title: "테스트 시작", size: 16, weight: .medium)
        $0.isActivated = true
        $0.addTarget(self, action: #selector(touchUpTestButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        setStatusBar(.background)
        view.backgroundColor = .background
    }
    
    private func setLayout() {
        view.addSubviews([closeButton, typoImageView, contentLabel, graphicImageView, testButton])
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(1)
            $0.trailing.equalToSuperview().inset(9)
            $0.width.height.equalTo(48)
        }
        
        typoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(115)
            $0.width.equalTo(254)
            $0.height.equalTo(37)
            $0.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(typoImageView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        graphicImageView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(22.33)
            $0.width.height.equalTo(325)
            $0.centerX.equalToSuperview()
        }
        
        testButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpCloseButton() {
        dismiss(animated: true)
    }
    
    @objc func touchUpTestButton() {
        let vc = TestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
