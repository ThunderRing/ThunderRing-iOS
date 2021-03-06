//
//  MyPageAlarmTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

import SnapKit
import Then

final class MyPageAlarmTableViewCell: UITableViewCell {
    static let identifier = "MyPageAlarmTableViewCell"
    
    // MARK: - Properties
    
    private var label = UILabel().then {
        $0.text = "알림"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private lazy var alarmSwitch = UISwitch().then {
        $0.onTintColor = .purple100
        $0.isOn = true
        $0.isEnabled = true
        $0.addTarget(self, action: #selector(touchUpSwitch), for: .touchUpInside)
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
    
    private func configUI() {
        backgroundColor = .background
    }
    
    private func setLayout() {
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
    
    // MARK: - @objc
    
    @objc func touchUpSwitch(sender: UISwitch){
        // FIXME: - 알람 켰을 때와 껐을 때 분기 처리 (커스텀 팝업)
        if sender.isOn {
            
        } else {
            
        }
    }
}

