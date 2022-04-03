//
//  PrivateDetailMemberCollectionViewCell.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/30.
//

import UIKit

import SnapKit
import Then

final class PrivateDetailMemberCollectionViewCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    private lazy var memberImageView = UIImageView().then {
        $0.image = UIImage(named: "imgNeedle")
    }
    
    private lazy var memberNameLabel = UILabel().then {
        $0.text = "사용자"
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
    
    // MARK: - Custom Method
    
    private func configUI() {
        backgroundColor = .clear
        
        memberImageView.makeRounded(cornerRadius: 19)
    }
    
    private func setLayout() {
        addSubviews([memberImageView, memberNameLabel])
        
        memberImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(53)
            $0.height.equalTo(55)
        }
        
        memberNameLabel.snp.makeConstraints {
            $0.top.equalTo(memberImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
