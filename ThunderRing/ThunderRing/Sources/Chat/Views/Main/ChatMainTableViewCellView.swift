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
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "동물농장 같이 봐요"
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var memberCountLabel = UILabel().then {
        $0.text = "20"
        $0.textColor = .gray200
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.text = "댕댕쓰"
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.text = "어쩌구저쩌구동물농장시작합니당어쩌구저쩌구울랄라"
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private lazy var timeLabel = UILabel().then {
        $0.text = "20분전"
        $0.textColor = .gray200
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private lazy var alarmView = AlarmView()
    
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
        
        addSubviews([chatImageView,
                     titleLabel,
                     memberCountLabel,
                     subTitleLabel,
                     contentLabel,
                     timeLabel,
                     alarmView,
                     lineView])
        
        chatImageView.makeRounded(cornerRadius: 8.33)
    }
    
    private func setLayout() {
        chatImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(chatImageView.snp.trailing).offset(14)
        }
        
        memberCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(chatImageView.snp.trailing).offset(14)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(chatImageView.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().inset(26)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview()
        }
        
        alarmView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(23)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(24)
            $0.height.equalTo(17)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(64)
            $0.height.equalTo(1)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(6)
        }
    }
}

fileprivate final class AlarmView: UIView {
    
    private lazy var label = UILabel().then {
        $0.text = "1"
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 12)
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
