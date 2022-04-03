//
//  PrivateDetailHistoryCollectionViewCell.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/30.
//

import UIKit

import SnapKit
import Then

final class PrivateDetailHistoryCollectionViewCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    private lazy var dateLabel = UILabel().then {
        $0.text = "21/08/03"
        $0.textColor = .gray150
        $0.font = .DINPro(type: .regular, size: 14)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "이태원 모각작 모아요"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 14)
    }
    
    private lazy var memberImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_people_small")
    }
    
    private lazy var memberCountLabel = UILabel().then {
        $0.text = "4명"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private lazy var locationImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_location_small")
    }
    
    private lazy var locationCountLabel = UILabel().then {
        $0.text = "이태원역 4번출구"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        contentView.backgroundColor = .white
        contentView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 10, bounds: true)
    }
    
    private func setLayout() {
        contentView.addSubviews([dateLabel, titleLabel, memberImageView, memberCountLabel, locationImageView, locationCountLabel])
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(13)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(13)
        }
        
        memberImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(20)
        }
        
        memberCountLabel.snp.makeConstraints {
            $0.leading.equalTo(memberImageView.snp.trailing).offset(2)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        locationImageView.snp.makeConstraints {
            $0.top.equalTo(memberImageView.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(20)
        }
        
        locationCountLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImageView.snp.trailing).offset(2)
            $0.top.equalTo(memberCountLabel.snp.bottom).offset(7)
        }
    }
}
