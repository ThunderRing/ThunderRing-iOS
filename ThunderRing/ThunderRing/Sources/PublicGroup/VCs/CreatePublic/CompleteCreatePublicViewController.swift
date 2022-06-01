//
//  CompleteCreatePublicVC.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/05.
//

import UIKit

import SnapKit
import Then

final class CompleteCreatePublicViewController: UIViewController {

    // MARK: - Properties
    
    private var contentImageView = UIImageView().then {
        $0.image = UIImage(named: "img_groupComplete")
        $0.contentMode = .scaleAspectFit
    }
    
    private var typoImageView = UIImageView().then {
        $0.image = UIImage(named: "text_groupComplete")
        $0.contentMode = .scaleAspectFill
    }
    
    private var contentLabel = UILabel().then {
        $0.text =
        """
        새로운 그룹이 생성되었어요
        그룹원들에게 첫번째로 번개를 쳐보세요!
        """
        $0.numberOfLines = 2
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
        $0.setTextSpacingBy(value: -0.6)
        $0.setLineSpacing(lineSpacing: 7, lineHeightMultiple: 0)
        $0.textAlignment = .center
    }
    
    private lazy var createButton = TDSButton().then {
        $0.addTarget(self, action: #selector(touchUpCreateButton), for: .touchUpInside)
        $0.setTitleWithStyle(title: "확인", size: 16, weight: .medium)
        $0.isActivated = true
    }
    
    var groupName: String = ""
    var groupDescription: String = ""
    
    var isPrivate: Bool = false
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        setStatusBar(.background)
        view.backgroundColor = .background
        
        createButton.layer.cornerRadius = 26
        createButton.layer.masksToBounds = true
    }
    
    private func setLayout() {
        view.addSubviews([contentImageView,
                          typoImageView,
                          contentLabel,
                          createButton
                         ])
        
        contentImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(110)
            $0.width.height.equalTo(270)
            $0.centerX.equalToSuperview()
        }
        
        typoImageView.snp.makeConstraints {
            $0.top.equalTo(contentImageView.snp.bottom).inset(27)
            $0.width.equalTo(180)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(typoImageView.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        
        createButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpCreateButton() {
        if !isPrivate { NotificationCenter.default.post(name: NSNotification.Name("CreateNewPublicGroup"), object: nil) }
        dismiss(animated: true)
    }
}
