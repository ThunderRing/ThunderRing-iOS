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
        $0.layer.cornerRadius = 22
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
    }
    
    private var profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var nicknameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.sizeToFit()
    }
    
    var chatGrayBackView = UIView().then {
        $0.backgroundColor = .gray350
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var couterpartTextLabel = BasePaddingLabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
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
    
    private var sendTimeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 11)
        $0.textColor = .gray
        $0.sizeToFit()
    }
    
    // MARK: - init
    func initUI(model: MessageData) {
        bindData(data: model)
        configureLayout()
    }
    
    func bindData(data: MessageData) {
        profileImageView.image = UIImage(named: data.profileImageName)
        nicknameLabel.text = data.nickname
        couterpartTextLabel.text = data.messageText
        sendTimeLabel.text = data.sendTime
    }
    
    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        chatGrayBackView.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 10.0)
        profileImageView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 22)
    }
}
// MARK: - Layout
extension CounterpartChatCVC {
    func configureLayout() {
        self.addSubviews([profileBorderView, profileImageView, nicknameLabel, chatGrayBackView, couterpartTextLabel, sendTimeLabel])
        
        profileBorderView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading).offset(17)
            $0.height.equalTo(44)
            $0.width.equalTo(profileBorderView.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        profileImageView.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.width.equalTo(profileImageView.snp.height).multipliedBy(1.0 / 1.0)
            $0.centerX.equalTo(profileBorderView)
            $0.centerY.equalTo(profileBorderView)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(profileBorderView.snp.trailing).offset(7)
        }
        
        couterpartTextLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(5)
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

