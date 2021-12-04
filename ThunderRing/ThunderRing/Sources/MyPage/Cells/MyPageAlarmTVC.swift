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
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
    }
    
    private var alarmSwitch = UISwitch().then {
        $0.onTintColor = .purple100
        $0.isOn = true
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

extension MyPageAlarmTVC {
    func setLayout() {
        self.addSubviews([label, alarmSwitch])
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        alarmSwitch.snp.makeConstraints {
            $0.leading.equalTo(label.snp.trailing).offset(215)
            $0.centerY.equalToSuperview()
        }
    }
}
