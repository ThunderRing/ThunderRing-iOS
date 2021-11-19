//
//  TestTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/19.
//

import UIKit

class TestTVC: UITableViewCell {
    static let identifier = "TestTVC"
    
    // MARK: - UI
    
    private var titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }

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
        
        if selected {
            contentView.layer.borderWidth = 2
            contentView.layer.borderColor = UIColor.purple.cgColor
            
            contentView.backgroundColor = .systemGray6
            contentView.layer.cornerRadius = 10
            contentView.layer.masksToBounds = true
        } else {
            contentView.layer.borderWidth = 0
            contentView.layer.borderColor = UIColor.systemGray6.cgColor
            
            contentView.backgroundColor = .systemGray6
            contentView.layer.cornerRadius = 10
            contentView.layer.masksToBounds = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 9.0, left: 25, bottom: 9, right: 25))
    }
}

extension TestTVC {
    private func setLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}

extension TestTVC {
    func initCell(title: String) {
        titleLabel.text = title
    }
}
