//
//  HomeJoinView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/11.
//

import UIKit

import SnapKit
import Then

protocol HomeJoinViewDelegate: AnyObject {
    func touchUpCancelButton()
    func touchUpJoinButton()
}

final class HomeJoinView: UIView {
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "번개 참여"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 17)
    }
    
    private lazy var subtitleLabel = UILabel().then {
        $0.text = "해당 번개에 참여 하시겠습니까?"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    private lazy var cancelButton = JoinButton(type: .cancel).then {
        $0.addTarget(self, action: #selector(touchUpCancelButton), for: .touchUpInside)
    }
    
    private lazy var joinButton = JoinButton(type: .join).then {
        $0.addTarget(self, action: #selector(touchUpJoinButton), for: .touchUpInside)
    }
    
    weak var delegate: HomeJoinViewDelegate?
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .white
        
        cancelButton.makeRounded(cornerRadius: 9)
        cancelButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        joinButton.makeRounded(cornerRadius: 9)
        joinButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
    
    private func setLayout() {
        addSubviews([titleLabel, subtitleLabel, buttonStackView])
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(joinButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(54)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(126)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpCancelButton() {
        delegate?.touchUpCancelButton()
    }
    
    @objc func touchUpJoinButton() {
        delegate?.touchUpJoinButton()
    }
}
