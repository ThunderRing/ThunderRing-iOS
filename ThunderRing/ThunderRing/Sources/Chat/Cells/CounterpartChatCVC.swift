//
//  CounterpartChatCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/04.
//

import UIKit

import SnapKit
import Then

class CounterpartChatCVC: BaseCell {
    static let identifier = "CounterpartChatCVC"
    
    // MARK: - Properties
    
    private var profileBorderView = UIImageView().then {
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
    }
    
    var profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.makeRounded(cornerRadius: 15)
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
    }
    
    private var nicknameLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.textAlignment = .left
        $0.sizeToFit()
    }
    
    var chatGrayBackView = UIView().then {
        $0.backgroundColor = .gray350
//        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var couterpartTextLabel = BasePaddingLabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
        $0.setTextSpacingBy(value: -4)
        $0.textAlignment = .left
        $0.letterSpacing = -0.39
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.paddingTop = 12
        $0.paddingLeft = 10
        $0.paddingRight = 12
        $0.paddingBottom = 10
        $0.sizeToFit()
    }
    
    var sendTimeLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 10)
        $0.textColor = .gray200
        $0.sizeToFit()
    }
    
    // MARK: - init
    func initUI(model: MessageData, userModel: UserInfoModel) {
        bindData(data: model, userData: userModel)
        configureLayout()
    }
    
    func bindData(data: MessageData, userData: UserInfoModel) {
        profileImageView.image = UIImage(named: userData.profileImageName!)
        nicknameLabel.text = userData.userName
        
        couterpartTextLabel.text = data.messageText
        sendTimeLabel.text = data.timeStamp?.toDayTime
    }
    
    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        chatGrayBackView.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 15.0)
    }
}
// MARK: - Layout
extension CounterpartChatCVC {
    func configureLayout() {
        self.addSubviews([profileBorderView, profileImageView, nicknameLabel, chatGrayBackView, couterpartTextLabel, sendTimeLabel])
        
        profileBorderView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading).offset(25)
            $0.height.equalTo(42)
            $0.width.equalTo(profileBorderView.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        profileImageView.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.width.equalTo(profileImageView.snp.height).multipliedBy(1.0 / 1.0)
            $0.centerX.equalTo(profileBorderView)
            $0.centerY.equalTo(profileBorderView)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(profileBorderView.snp.trailing).offset(7)
        }
        
        couterpartTextLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.width.lessThanOrEqualTo(220)
        }
        
        chatGrayBackView.snp.makeConstraints {
            $0.top.equalTo(couterpartTextLabel.snp.top)
            $0.leading.equalTo(couterpartTextLabel.snp.leading)
            $0.trailing.equalTo(couterpartTextLabel.snp.trailing)
            $0.bottom.equalTo(couterpartTextLabel.snp.bottom)
        }
        
        sendTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(couterpartTextLabel.snp.trailing).offset(8)
            $0.bottom.equalTo(couterpartTextLabel.snp.bottom).offset(0)
        }
    }
}

