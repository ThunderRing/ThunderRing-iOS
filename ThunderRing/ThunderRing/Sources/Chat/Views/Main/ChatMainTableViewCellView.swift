//
//  ChatMainTableViewCellView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/19.
//

import UIKit

import SnapKit
import Then

final class ChatMainTableViewCellView: UIView {
    
    var chatImageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 19)
    }
    
    var titleLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    var memberCountLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 16)
    }
    
    var subTitleLabel = UILabel().then {
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    var contentLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        $0.lineBreakMode = .byTruncatingTail
    }
    
    var timeLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    var messageCountView = MessageCountView()
    
    private lazy var lineView = UIView().then {
        // FIXME: - 색상변경
        $0.backgroundColor = .gray300
    }
    
    // MARK: - Initialzier
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - init UI
    
    private func configUI() {
        backgroundColor = .background
    }
    
    private func setLayout() {
        addSubviews([chatImageView,
                     titleLabel,
                     memberCountLabel,
                     subTitleLabel,
                     contentLabel,
                     timeLabel,
                     messageCountView,
                     lineView])
        
        chatImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(53)
            $0.height.equalTo(55)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(chatImageView.snp.trailing).offset(13)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(chatImageView.snp.trailing).offset(13)
        }
        
        memberCountLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.top).offset(17)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(chatImageView.snp.trailing).offset(13)
            $0.trailing.equalToSuperview().inset(35)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.trailing.equalToSuperview()
        }
        
        messageCountView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(9)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(31)
            $0.height.equalTo(17)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

final class MessageCountView: UIView {
    
    var label = UILabel().then {
        $0.text = "10"
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 12)
        $0.textAlignment = .center
        $0.setTextSpacingBy(value: -0.6)
    }
    
    var messageCount: Int = 0 {
        didSet {
            label.text = "\(messageCount)"
            label.setTextSpacingBy(value: -0.6)
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setView()
       
//        if messageCount != 0 {
//            setView()
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        self.makeRounded(cornerRadius: 5)
        self.backgroundColor = .purple300
        addSubview(label)
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(1)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
}
