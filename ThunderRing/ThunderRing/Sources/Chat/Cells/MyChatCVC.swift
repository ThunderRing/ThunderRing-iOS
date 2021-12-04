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
    }
    
    private var myTextLabel = BasePaddingLabel().then {
        $0.font = .systemFont(ofSize: 14)
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
        myTextLabel.text = data.messageText
        sendTimeLabel.text = data.sendTime
    }
    
    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        chatPurpleBackView.roundCorners(corners: [.topLeft, .bottomLeft, .bottomRight], radius: 10.0)
    }
}

extension MyChatCVC {
    func configureLayout() {
        self.addSubviews([chatPurpleBackView, myTextLabel, sendTimeLabel])
        
        myTextLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(0)
            $0.trailing.equalTo(self.snp.trailing).offset(-23)
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

