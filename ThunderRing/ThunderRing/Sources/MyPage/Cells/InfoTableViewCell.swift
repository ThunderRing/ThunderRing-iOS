//
//  InfoTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

import SnapKit
import Then

final class InfoTableViewCell: UITableViewCell {
    static let identifier = "InfoTableViewCell"

    // MARK: - Properties
    
    private var label = UILabel().then {
        $0.text = "서비스 관련 법률 및 개인정보"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
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
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
}
