//
//  PopUpView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/06.
//

import UIKit

import SnapKit
import Then

protocol PopUpViewDelegate: AnyObject {
    func touchUpCancelButton()
    func touchUpJoinButton()
}

final class PopUpView: UIView {
    
    // MARK: - Properties
    
    private var alarmIconView = UIView().then {
        $0.backgroundColor = .yellow300
        $0.makeRounded(cornerRadius: 15)
    }
    
    private var alarmIconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "icn_beon_small")
    }
    
    private var lightningNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 16)
    }
    
    private var groupNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = .gray350
    }
    
    private var contentLabel = UILabel().then {
        $0.text = "연남동에 맛있는 젤리 가게가 있다는데 같이 먹으러 갈 사람 구한다"
        $0.setTextSpacingBy(value: -0.6)
        $0.numberOfLines = 0
        $0.textColor = .gray100
        $0.textAlignment = .left
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private var memberImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_people_small")
    }
    
    private var memberCountLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private var dateImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_small_clock")
    }
    
    private var dateLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private var locationImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_location_small")
    }
    
    private var locationLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private var timeTagView = UIView().then {
        $0.backgroundColor = .clear
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 11.5, bounds: true)
    }
    
    private var timeTagLabel = UILabel().then {
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
        $0.setTextSpacingBy(value: -0.6)
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
    
    var memberCount: Int = 0 {
        didSet {
            memberCountLabel.text = "\(memberCount)명"
            memberCountLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var date: String = "" {
        didSet {
            dateLabel.text = date
            dateLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var location: String = "" {
        didSet {
            locationLabel.text = location
            locationLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var alarmType: AlarmType = .lightning
    
    weak var delegate: PopUpViewDelegate?
    
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
        
        cancelButton.makeRounded(cornerRadius: 8)
        cancelButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        joinButton.makeRounded(cornerRadius: 8)
        joinButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
    
    private func setLayout() {
        addSubviews([alarmIconView,
                     lightningNameLabel,
                     groupNameLabel,
                     lineView,
                     contentLabel,
                     memberImageView,
                     memberCountLabel,
                     dateImageView,
                     dateLabel,
                     locationImageView,
                     locationLabel,
                     timeTagView,
                     buttonStackView])
        alarmIconView.addSubview(alarmIconImageView)
        alarmIconImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        timeTagView.addSubview(timeTagLabel)
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(joinButton)
        
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
            $0.height.equalTo(36)
        }
        
        memberImageView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(17)
            $0.leading.equalToSuperview().inset(27)
            $0.width.height.equalTo(20)
        }
        
        memberCountLabel.snp.makeConstraints {
            $0.leading.equalTo(memberImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(memberImageView.snp.centerY)
        }
        
        dateImageView.snp.makeConstraints {
            $0.top.equalTo(memberImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(27)
            $0.width.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(dateImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(dateImageView.snp.centerY)
        }
        
        locationImageView.snp.makeConstraints {
            $0.top.equalTo(dateImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(27)
            $0.width.height.equalTo(20)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(locationImageView.snp.centerY)
        }
        
        timeTagView.snp.makeConstraints {
            $0.top.equalTo(locationImageView.snp.bottom).offset(19)
            $0.width.equalTo(166)
            $0.height.equalTo(23)
            $0.centerX.equalToSuperview()
        }
        
        timeTagLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(14)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(341)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Method
    
    func updateView() {
        switch alarmType {
        case .thunder:
            return
        case .lightning:
            timeTagLabel.text = "모집 시간: \(Const.Lightning.DateAndTime)까지"
            timeTagLabel.setTextSpacingBy(value: -0.6)
            
            timeTagView.snp.updateConstraints {
                $0.top.equalTo(locationImageView.snp.bottom).offset(19)
                $0.width.equalTo(calculateViewWidth())
                $0.height.equalTo(23)
                $0.centerX.equalToSuperview()
            }
            return
        case .cancel:
            timeTagView.initViewBorder(borderWidth: 1, borderColor: UIColor.red.cgColor, cornerRadius: 11.5, bounds: true)
            
            timeTagView.snp.updateConstraints {
                $0.top.equalTo(locationImageView.snp.bottom).offset(19)
                $0.width.equalTo(152)
                $0.height.equalTo(23)
                $0.centerX.equalToSuperview()
            }
            
            timeTagLabel.text = "모집 시간이 지난 번개에요"
            timeTagLabel.setTextSpacingBy(value: -0.6)
            
            buttonStackView.removeArrangedSubview(cancelButton)
            cancelButton.removeFromSuperview()
        }
    }
    
    private func calculateViewWidth() -> CGFloat {
        let label = UILabel()
        label.text = "모집 시간: \(Const.Lightning.DateAndTime)까지"
        label.setTextSpacingBy(value: -0.6)
        label.font = .SpoqaHanSansNeo(type: .regular, size: 12)
        label.sizeToFit()
        return label.frame.width + 14 + 14
    }
    
    // MARK: - @objc
    
    @objc func touchUpCancelButton() {
        delegate?.touchUpCancelButton()
    }
    
    @objc func touchUpJoinButton() {
        delegate?.touchUpJoinButton()
    }
}
