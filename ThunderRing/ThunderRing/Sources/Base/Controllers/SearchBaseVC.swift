//
//  SearchBaseVC.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/26.
//

import UIKit

import SnapKit
import Then

final class SearchBaseVC: UIViewController {

    // MARK: - Properties
    
    private lazy var navigationBarView = CustomNavigationBar(vc: self, title: "", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .background)
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        
    }
    
    // MARK: - Custom Method

}
