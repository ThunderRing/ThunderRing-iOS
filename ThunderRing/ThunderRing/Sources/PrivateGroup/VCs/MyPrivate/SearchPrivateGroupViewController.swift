//
//  SearchPrivateGroupVC.swift
//  ThunderRing
//
//  Created by 소연 on 2022/02/27.
//

import UIKit

import SnapKit
import Then

final class SearchPrivateGroupViewController: SearchBaseVC {

    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        
        navigationBarView.setTitle(title: "비공개 그룹")
    }
    
    private func setLayout() {
        
    }
    
    // MARK: - Custom Method
}
