//
//  AlarmPopUpViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/10.
//

import UIKit

import SnapKit
import Then

final class AlarmPopUpViewController: UIViewController {

    // MARK: - Properties
    
    private var lightningView = UIView().then {
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    
    private var cancelView = UIView().then {
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    
    private var alarmImageView = UIImageView().then {
        $0.image = UIImage(named: " ")
        $0.backgroundColor = .yellow200
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "이태원 모각작 모아요"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 16)
    }
    
    private var subTitleLabel = UILabel().then {
        $0.text = "[양파링걸즈] 마예똥"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = .gray350
    }
    
    private var descriptionLabel = UILabel().then {
        $0.text = "오늘 이태원에서 모각작하고 같이 하실래요?\n저녁도 시간나면 먹어요"
        $0.setTextSpacingBy(value: -0.6)
        $0.numberOfLines = 0
        $0.textColor = .gray100
        $0.textAlignment = .left
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private lazy var memberImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_people_small")
    }
    
    private lazy var memberCountLabel = UILabel().then {
        $0.text = "4명"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private lazy var timeImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_small_clock")
    }
    
    private lazy var timeLabel = UILabel().then {
        $0.text = "8월 3일 목요일 오전 11:00"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private lazy var locationImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_location_small")
    }
    
    private lazy var locationLabel = UILabel().then {
        $0.text = "이태원역 4번출구 할리스"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
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

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        lightningView.makeRounded(cornerRadius: 8)
        
        cancelButton.makeRounded(cornerRadius: 8)
        cancelButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        joinButton.makeRounded(cornerRadius: 8)
        joinButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
    
    private func setLayout() {
        view.addSubview(lightningView)
        
        lightningView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(222)
            $0.leading.trailing.equalToSuperview().inset(42)
            $0.bottom.equalToSuperview().inset(242)
        }
        
        lightningView.addSubviews([alarmImageView,
                                   titleLabel,
                                   subTitleLabel,
                                   lineView,
                                   descriptionLabel,
                                   memberImageView,
                                   memberCountLabel,
                                   timeImageView,
                                   timeLabel,
                                   locationImageView,
                                   locationLabel,
                                   buttonStackView])
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(joinButton)
        
        alarmImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.width.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alarmImageView.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(13)
            $0.height.equalTo(1)
            $0.width.equalTo(251)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.height.equalTo(36)
        }
        
        memberImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(17)
            $0.leading.equalToSuperview().inset(27)
            $0.width.height.equalTo(20)
        }
        
        memberCountLabel.snp.makeConstraints {
            $0.leading.equalTo(memberImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(memberImageView.snp.centerY)
        }
        
        timeImageView.snp.makeConstraints {
            $0.top.equalTo(memberImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(27)
            $0.width.height.equalTo(20)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(timeImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(timeImageView.snp.centerY)
        }
        
        locationImageView.snp.makeConstraints {
            $0.top.equalTo(timeImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(27)
            $0.width.height.equalTo(20)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(locationImageView.snp.centerY)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(300)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    internal func handleTap(alarmType: AlarmItemType) {
        switch alarmType {
        case .thunder:
            lightningView.isHidden = false
            cancelView.isHidden = true
        case .lightning:
            lightningView.isHidden = false
            cancelView.isHidden = true
        case .cancel:
            lightningView.isHidden = true
            cancelView.isHidden = false
        }
    }

    // MARK: - @objc
    
    @objc func touchUpCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func touchUpJoinButton() {
        // FIXME: - 수락 이벤트 처리
        dismiss(animated: true)
    }
}

// MARK: - Button

enum PopUpButtonType {
    case cancel
    case join
    
    var title: String {
        switch self {
        case .cancel:
            return "무시"
        case .join:
            return "참여"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .cancel:
            return .gray300
        case .join:
            return .purple100
        }
    }
    
    var foregroundColor: UIColor {
        switch self {
        case .cancel:
            return .gray150
        case .join:
            return .white
        }
    }
}

fileprivate final class JoinButton: UIButton {
    private var type: PopUpButtonType = .join
    
    private lazy var label = UILabel().then {
        $0.text = type.title
        $0.textColor = type.foregroundColor
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 13)
    }
    
    init(type: PopUpButtonType) {
        super.init(frame: .zero)
        self.type = type
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        backgroundColor = type.backgroundColor
        addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
