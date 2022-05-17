//
//  AlarmMainCancelView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/06.
//

import UIKit

import SnapKit
import Then

protocol AlarmMainItemViewDelegate: AnyObject {
    func touchUpThunderView()
    func touchUpLightningView()
    func touchUpCancelView()
}

final class AlarmMainItemView: UIView {
    private lazy var type: AlarmItemType = .thunder
    
    var alarmType: AlarmItemType = .thunder {
        didSet {
            self.type = alarmType
            
            switch type {
            case .thunder:
                alarmImageView.image = UIImage(named: "icn_cheon")
            case .lightning:
                alarmImageView.image = UIImage(named: "icn_beon")
            case .cancel:
                alarmImageView.image = UIImage(named: "icn_beon_chi")
            }
        }
    }

    private var contentView = UIView().then {
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 10, bounds: true)
    }
    
    private lazy var alarmView = UIView().then {
        $0.backgroundColor = alarmType.color
        $0.makeRounded(cornerRadius: 14)
    }
    
    private var alarmImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
        $0.text = type.title
        $0.textAlignment = .center
        $0.textColor = .gray100
    }
    
    private lazy var subtitleLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
        $0.text = type.subTitle
        $0.textColor = .black
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
        $0.text = type.description
        $0.textColor = .gray100
    }
    
    private lazy var timeLabel = UILabel().then {
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = "\(title)"
            titleLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var subTitle: String = "" {
        didSet {
            subtitleLabel.text = "\(subTitle)"
            subtitleLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var alarmDescription: String = "" {
        didSet {
            descriptionLabel.text = "\(alarmDescription)"
            descriptionLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var time: String = "10" {
        didSet {
            timeLabel.text = "\(time)"
            timeLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var isActive: Bool = true {
        didSet {
            alarmView.backgroundColor = isActive ? type.color : .gray350
            if !isActive { alarmImageView.image = UIImage(named: "icn_beon_inactive")}
            titleLabel.textColor = isActive ? .black : .gray100
            subtitleLabel.textColor = isActive ? .black : .gray100
        }
    }

    // MARK: - Initializer
    
    init(alarmType: AlarmItemType, isActive: Bool) {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        backgroundColor = .background
    }
    
    private func setLayout() {
        addSubview(contentView)
        contentView.addSubviews([alarmView, titleLabel, subtitleLabel, descriptionLabel, timeLabel])
        alarmView.addSubview(alarmImageView)
        
        alarmImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.top.bottom.equalToSuperview().inset(3.5)
        }
        
        alarmView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(15)
            $0.width.equalTo(40)
            $0.height.equalTo(42)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalTo(alarmView.snp.trailing).offset(10)
            $0.height.equalTo(19)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.height.equalTo(19)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(alarmView.snp.trailing).offset(10)
            $0.bottom.equalToSuperview().inset(18)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(41)
        }
    }
}

// MARK: - AlarmType

enum AlarmItemType {
    case thunder
    case lightning
    case cancel
    
    var title: String {
        return "[그룹명]"
    }
    
    var subTitle: String {
        return "번개명"
    }
    
    var description: String {
        switch self {
        case .thunder:
            return "번개가 취소되었어요"
        case .lightning:
            return "천둥이 울렸어요. 채팅을 볼까요?"
        case .cancel:
            return "번개가 도착했어요. 내용을 확인해보세요"
        }
    }
    
    var color: UIColor {
        switch self {
        case .thunder:
            return .blue200
        case .lightning:
            return .yellow300
        case .cancel:
            return .pink200
        }
    }
}
