//
//  MyPageAlarmTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

import SnapKit
import Then

class MyPageAlarmTVC: UITableViewCell {
    static let identifier = "MyPageAlarmTVC"
    
    // MARK: - UI
    
    private var label = UILabel().then {
        $0.text = "알림"
//        $0.font = .SpoqaHanSansNeo(.regular, size: 16)
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

extension MyPageAlarmTVC {
    func setLayout() {
        self.addSubviews([label])
        
        label.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
    }
}
