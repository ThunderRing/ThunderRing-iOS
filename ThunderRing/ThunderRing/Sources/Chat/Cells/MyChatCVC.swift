//
//  MyChatCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/04.
//

import UIKit

import SnapKit
import Then

class MyChatCVC: BaseCell {
    static let identifier = "MyChatCVC"
    
    // MARK: - Properties
    
    var chatPurpleBackView = UIView().then {
        $0.backgroundColor = .purple100
//        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
    }
    
    var myTextLabel = BasePaddingLabel().then {
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
        $0.setTextSpacingBy(value: -4)
        $0.textColor = .white
        $0.textAlignment = .left
        $0.letterSpacing = -0.39
        $0.paddingTop = 12
        $0.paddingLeft = 10
        $0.paddingRight = 12
        $0.paddingBottom = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.sizeToFit()
    }
    
    var sendTimeLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 10)
        $0.textColor = .gray200
        $0.sizeToFit()
    }
    
    // MARK: - init
    
    func initUI(model: MessageData) {
        bindData(data: model)
        configureLayout()
    }
    
    func bindData(data: MessageData) {
        myTextLabel.text = data.messageText
        sendTimeLabel.text = data.timeStamp?.toDayTime
    }
    
    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        chatPurpleBackView.roundCorners(corners: [.topLeft, .bottomLeft, .bottomRight], radius: 15.0)
    }
}

extension MyChatCVC {
    func configureLayout() {
        self.addSubviews([chatPurpleBackView, myTextLabel, sendTimeLabel])
        
        myTextLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(0)
            $0.trailing.equalTo(self.snp.trailing).offset(-25)
            $0.width.lessThanOrEqualTo(220)
        }
        
        chatPurpleBackView.snp.makeConstraints {
            $0.top.equalTo(myTextLabel.snp.top)
            $0.leading.equalTo(myTextLabel.snp.leading)
            $0.trailing.equalTo(myTextLabel.snp.trailing)
            $0.bottom.equalTo(myTextLabel.snp.bottom)
        }
        sendTimeLabel.snp.makeConstraints {
            $0.trailing.equalTo(chatPurpleBackView.snp.leading).offset(-8)
            $0.bottom.equalTo(chatPurpleBackView.snp.bottom).offset(0)
        }
    }
}

