//
//  AccountTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

import SnapKit
import Then

final class AccountTableViewCell: UITableViewCell {
    static let identifier = "AccountTableViewCell"
    
    // MARK: - Properties
    
    private var label = UILabel().then {
        $0.text = "계좌 정보"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private var moreImageView = UIImageView().then {
        $0.image = UIImage(named: "btn_more_right")
    }

    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    func configUI() {
        backgroundColor = .background
    }
    
    func setLayout() {
        contentView.addSubviews([label, moreImageView])
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        moreImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(2)
            $0.leading.equalTo(label.snp.trailing).offset(220)
            $0.width.height.equalTo(48)
        }
    }
}
