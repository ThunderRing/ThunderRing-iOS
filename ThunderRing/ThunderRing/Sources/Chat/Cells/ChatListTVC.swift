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
    
    private var label = UILabel().then {
        $0.text = "알림"
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

extension ChatListTVC {
    func setLayout() {
        self.addSubviews([label])
        
        label.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
    }
}
