//
//  ChatListTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/13.
//

import UIKit

class ChatListTVC: UITableViewCell {
    static let identifier = "ChatListTVC"

    // MARK: - UI
    
    private var backView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private var hashTagLabel = UILabel().then {
        $0.text = " 양파링 걸즈 "
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.purple.cgColor
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "모각공 할 사람"
        $0.textColor = .black
    }
    
    private var subTitleLabel = UILabel().then {
        $0.text = "채팅을 먼저 시작해보세요.."
        $0.textColor = .darkGray
    }
    
    private var countLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .lightGray
    }
    
    private var timeLabel = UILabel().then {
        $0.text = "시간 전"
        $0.textColor = .lightGray
    }
    
    // MARK: - Properties
    
    private var count = 0

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension ChatListTVC {
    func setLayout() {
        contentView.addSubview(backView)
        backView.addSubviews([hashTagLabel, titleLabel, subTitleLabel, countLabel, timeLabel])
        
        backView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.top.bottom.equalToSuperview().inset(7)
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
