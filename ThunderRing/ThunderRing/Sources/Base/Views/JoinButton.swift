//
//  JoinButton.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/06.
//

import UIKit

import SnapKit
import Then

enum JoinButtonType {
    case cancel
    case join
    
    var title: String {
        switch self {
        case .cancel:
            return "무시"
        case .join:
            return "참여"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .cancel:
            return .gray300
        case .join:
            return .purple100
        }
    }
    
    var foregroundColor: UIColor {
        switch self {
        case .cancel:
            return .gray150
        case .join:
            return .white
        }
    }
}

final class JoinButton: UIButton {
    private var type: JoinButtonType = .join
    
    private lazy var label = UILabel().then {
        $0.text = type.title
        $0.textColor = type.foregroundColor
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 13)
    }
    
    init(type: JoinButtonType) {
        super.init(frame: .zero)
        self.type = type
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        backgroundColor = type.backgroundColor
        addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
