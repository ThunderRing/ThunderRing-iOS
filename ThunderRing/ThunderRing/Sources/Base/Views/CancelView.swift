//
//  CancelView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/14.
//

import Foundation

import SnapKit
import Then

// MARK: - Cancel Pop Up View

protocol CancelViewDelegate: AnyObject {
    func touchUpConfirmButton()
}

final class CancelView: UIView {
    
    // MARK: - Properties
    
    private var alarmIconView = UIView().then {
        $0.backgroundColor = .pink200
        $0.makeRounded(cornerRadius: 15)
    }
    
    private var alarmIconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "icn_beon_chi_small")
    }
    
    private var lightningNameLabel = UILabel().then {
        $0.text = "번개이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 16)
    }
    
    private var groupNameLabel = UILabel().then {
        $0.text = "[그룹이름] 주최자이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = .gray350
    }
    
    private var contentLabel = UILabel().then {
        $0.text = "공덕역 카페로 번개 정원이\n충족되지 않았습니다"
        $0.setTextSpacingBy(value: -0.6)
        $0.numberOfLines = 0
        $0.textColor = .gray100
        $0.textAlignment = .center
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private lazy var confirmButton = UIButton().then {
        $0.backgroundColor = .purple100
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(touchUpConfirmButton), for: .touchUpInside)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 13)
        $0.titleLabel?.setTextSpacingBy(value: -0.6)
    }
    
    weak var delegate: CancelViewDelegate?
    
    var lightningName: String = "" {
        didSet {
            lightningNameLabel.text = lightningName
            lightningNameLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var groupName: String = "" {
        didSet {
            groupNameLabel.text = groupName
            groupNameLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var content: String = "" {
        didSet {
            contentLabel.text = content
            contentLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        backgroundColor = .white
        
        makeRounded(cornerRadius: 8)
        
        confirmButton.makeRounded(cornerRadius: 8)
        confirmButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    private func setLayout() {
        addSubviews([alarmIconView, lightningNameLabel, groupNameLabel, lineView, contentLabel, confirmButton])
        alarmIconView.addSubview(alarmIconImageView)
        alarmIconImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        alarmIconView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.width.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        lightningNameLabel.snp.makeConstraints {
            $0.top.equalTo(alarmIconView.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(lightningNameLabel.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(13)
            $0.height.equalTo(1)
            $0.width.equalTo(251)
            $0.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.height.equalTo(40)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(208)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpConfirmButton() {
        delegate?.touchUpConfirmButton()
    }
}

