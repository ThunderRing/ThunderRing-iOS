//
//  AlarmMainHeaderView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/06.
//

import UIKit

import SnapKit
import Then

protocol AlarmMainHeaderViewDelegate: AnyObject {
    func touchUpCheckButton()
}

final class AlarmMainHeaderView: UIView {
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "그룹 가입 요청"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = .gray350
    }

    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: AlarmMainHeaderViewDelegate?
    
    // MARK: - Init UI
    
    private func configUI() {
        backgroundColor = .background
    }
    
    private func setLayout() {
        addSubviews([titleLabel, lineView])
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(51)
            $0.top.equalToSuperview().inset(19)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        
    }
}
