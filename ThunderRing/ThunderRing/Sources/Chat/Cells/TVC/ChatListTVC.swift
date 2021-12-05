//
//  ChatListTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/13.
//

import UIKit

import SnapKit
import Then

class ChatListTVC: UITableViewCell {
    static let identifier = "ChatListTVC"

    // MARK: - UI
    
    private var backView = UIView().then {
        $0.backgroundColor = .white
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
    }
    
    private var chatImageView = UIImageView().then {
        $0.image = UIImage(named: "imgRabbit")
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 28, bounds: true)
    }
    
    private var hashTagLabel = UILabel().then {
        $0.text = "양파링 걸즈"
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "혜화역 혼가츠 먹어요!"
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 16)
    }
    
    private var subTitleLabel = UILabel().then {
        $0.text = "채팅을 먼저 시작해보세요.."
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private var countLabel = UILabel().then {
        $0.text = "8"
        $0.textColor = .lightGray
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var timeLabel = UILabel().then {
        $0.text = "시간 전"
        $0.textColor = .lightGray
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    // MARK: - Properties
    
    private var count = 0

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .background
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}

// MARK: - Custom Methods

extension ChatListTVC {
    private func setLayout() {
        contentView.addSubview(backView)
        backView.addSubviews([chatImageView, hashTagLabel, titleLabel, subTitleLabel, countLabel, timeLabel])
        
        backView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.top.bottom.equalToSuperview().inset(7)
        }
        
        chatImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(56)
        }
        
        hashTagLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(83)
            $0.top.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(83)
            $0.top.equalTo(hashTagLabel.snp.bottom).offset(5)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(83)
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

