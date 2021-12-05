//
//  AccountTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

class AccountTVC: UITableViewCell {
    static let identifier = "AccountTVC"

    // MARK: - UI
    
    private var label = UILabel().then {
        $0.text = "계좌정보"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }

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

extension AccountTVC {
    func setLayout() {
        self.addSubviews([label])
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
}

