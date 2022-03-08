//
//  RecruitingViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/09.
//

import UIKit

import SnapKit
import Then

final class HomeCruitingViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var navigationBar = TDSNavigationBar(self, view: .main, backButtonIsHidden: false, closeButtonIsHidden: true)

    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background
        
        navigationBar.setTitle(title: "모집 중인 번개")

    }
    
    private func setLayout() {

    }
    
}

