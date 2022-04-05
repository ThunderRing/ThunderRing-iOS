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
    
    private lazy var chatImageView = UIImageView().then {
        $0.image = UIImage(named: "imgDog1")
        $0.makeRounded(cornerRadius: 19)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "동물농장 같이 볼 사람? "
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var memberCountLabel = UILabel().then {
        $0.text = "20"
        $0.textColor = .gray200
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.text = "댕댕쓰"
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.text = "어쩌구저쩌구동물농장시작합니당어쩌구저쩌구울랄라"
        $0.numberOfLines = 1
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private lazy var timeLabel = UILabel().then {
        $0.text = "8분전"
        $0.textColor = .gray200
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private lazy var messageCountView = MessageCountView()
    
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
            $0.centerY.equalTo(titleLabel.snp.centerY)
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

fileprivate final class MessageCountView: UIView {
    
    private lazy var label = UILabel().then {
        $0.text = "10"
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 12)
    }
    
    var messageCount: Int = 0 {
        didSet {
            label.text = "\(messageCount)"
        }
    }
    
    init() {
        super.init(frame: .zero)
        setView()
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
