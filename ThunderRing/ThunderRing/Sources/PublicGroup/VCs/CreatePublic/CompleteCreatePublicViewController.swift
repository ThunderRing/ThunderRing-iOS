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
    
    private lazy var customNavigationBarView = CustomNavigationBar(vc: self, title: "", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .background)
    
    private var profileImageView = UIImageView().then {
        $0.image = UIImage(named: "imgDog1")
        $0.contentMode = .scaleAspectFit
        $0.makeRounded(cornerRadius: 40)
    }
    
    private var hashTagImageView = UIImageView().then {
        $0.image = UIImage(named: "tagCrowd")
        $0.contentMode = .scaleAspectFit
    }
    
    private var groupNameLabel = UILabel().then {
        $0.text = "그룹명"
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 20)
    }
    
    private var groupDescriptionLabel = UILabel().then {
        $0.text = "그룹 상세 설명"
        $0.textColor = .gray200
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private var createButton = UIButton().then {
        $0.setTitle("생성", for: .normal)
        $0.backgroundColor = .purple100
        $0.setTitleColor(.white, for: .normal)
        $0.makeRounded(cornerRadius: 26)
    }
    
    var groupName: String = "" {
        didSet {
            groupNameLabel.text = groupName
        }
    }
    
    var groupDescription: String = "" {
        didSet {
            groupDescriptionLabel.text = groupDescription
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setUpLayout()
    }
    
    // MARK: - InitUI
    
    private func configNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        createButton.layer.cornerRadius = 26
        createButton.layer.masksToBounds = true
    }
    
    private func setUpLayout() {
        view.addSubviews([customNavigationBarView,
                         profileImageView,
                         hashTagImageView,
                         groupNameLabel,
                         groupDescriptionLabel,
                         createButton])
        
        customNavigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBarView.snp.bottom).offset(153)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(120)
        }
        
        hashTagImageView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(21)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(hashTagImageView.snp.bottom).offset(19)
            $0.centerX.equalToSuperview()
        }
        
        groupDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        createButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - Custom Method
    
    
}
