//
//  HomeJoinViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/11.
//

import UIKit

import SnapKit
import Then

final class HomeJoinViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var joinView = HomeJoinView()
    
    // FIXME: - 이미지 수정 및 추가 (레이아웃)
    private lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = UIColor(red: 0.0 / 255.0 , green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.5)
        joinView.makeRounded(cornerRadius: 8)
    }
    
    private func setLayout() {
        view.addSubview(joinView)
        
        joinView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(323)
            $0.leading.trailing.equalToSuperview().inset(52)
            $0.height.equalTo(172)
        }
    }
}
