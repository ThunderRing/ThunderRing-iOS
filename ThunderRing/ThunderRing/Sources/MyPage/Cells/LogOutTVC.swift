//
//  LogOutTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

class LogOutTVC: UITableViewCell {
    static let identifier = "LogOutTVC"

    // MARK: - UI
    
    private var label = UILabel().then {
        $0.text = "로그아웃"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
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
    }

}

extension LogOutTVC {
    func setLayout() {
        self.addSubviews([label])
        
        label.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
    }
}

