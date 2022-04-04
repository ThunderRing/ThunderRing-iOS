//
//  SearchBaseVC.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/26.
//

import UIKit

import SnapKit
import Then

class SearchBaseVC: UIViewController {

    // MARK: - Properties
    
    lazy var navigationBarView = CustomNavigationBar(vc: self, title: "title", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .background)

    private var searchBar = TDSTextField()
    
    private var titleLabel = UILabel().then {
        $0.text = "최근 검색"
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var deleteAllButton = UIButton().then {
        $0.setTitle("전체 삭제", for: .normal)
        $0.setTitleColor(.gray100, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }
    
    private var emptyLabel = UILabel().then {
        $0.text = "검색한 기록이 없습니다."
        $0.textColor = .gray150
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background
        
        view.addSubviews([navigationBarView, searchBar, titleLabel, deleteAllButton, emptyLabel])
        
        setStatusBar(.white)
        navigationBarView.backgroundColor = .white
        navigationBarView.layer.applyShadow()
        
        guard let image = UIImage(named: "icnSearch") else { return }
        searchBar.setLeftIcon(16, 15, image)
        
        searchBar.setPlaceholder(placeholder: "그룹 명을 검색해보세요")
    }
    
    private func setLayout() {
        navigationBarView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.top.equalTo(navigationBarView.snp.bottom).offset(21)
            $0.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(35)
            $0.leading.equalToSuperview().inset(25)
        }
        
        deleteAllButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(37)
            $0.leading.equalToSuperview().inset(25)
        }
    }
}
