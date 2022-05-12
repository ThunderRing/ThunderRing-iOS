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
        }
    }

    private lazy var contentView = UIView().then {
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 10, bounds: true)
    }
    
    // FIXME: 그래픽 확정 시 이미지뷰로 변경
    private lazy var alarmImageView = UIView().then {
        $0.backgroundColor = type.color
        $0.makeRounded(cornerRadius: 14)
    }

    private lazy var titleLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
        $0.text = type.title
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
        $0.text = type.description
        $0.textAlignment = .center
        $0.textColor = .gray100
    }
    
    private lazy var timeLabel = UILabel().then {
        $0.text = "분"
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = "\(title)"
            titleLabel.setTextSpacingBy(value: -0.6)
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
            timeLabel.text = "\(time)시간 전"
            timeLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var isActive: Bool = true {
        didSet {
            alarmImageView.backgroundColor = isActive ? type.color : .gray100
            titleLabel.textColor = isActive ? .black : .gray100
        }
    }

    init(alarmType: AlarmItemType, isActive: Bool) {
        super.init(frame: .zero)
        self.type = alarmType
        configUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .background
    }
    
    private func setLayout() {
        addSubview(contentView)
        contentView.addSubviews([alarmImageView, titleLabel, descriptionLabel, timeLabel])
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.top.bottom.equalToSuperview().inset(3.5)
        }
        
        alarmImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(15)
            $0.width.equalTo(40)
            $0.height.equalTo(42)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalTo(alarmImageView.snp.trailing).offset(10)
            $0.height.equalTo(19)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(alarmImageView.snp.trailing).offset(10)
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
        return "[그룹명] 번개명"
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
            return .blue
        case .lightning:
            return .yellow200
        case .cancel:
            return .red
        }
    }
}
