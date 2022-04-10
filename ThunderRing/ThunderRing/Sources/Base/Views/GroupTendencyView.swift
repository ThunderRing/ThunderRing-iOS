//
//  GroupTagView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/29.
//

import UIKit

import SnapKit
import Then

final class GroupTendencyView: UIView {
    var tagType: TagType = .cozy {
        didSet {
            titlaLabel.text = tagType.title
            backgroundColor = tagType.color
        }
    }
    
    private lazy var titlaLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    init(tagType: TagType) {
        super.init(frame: .zero)
        self.tagType = tagType
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        addSubview(titlaLabel)
        titlaLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(3)
            $0.bottom.equalToSuperview().inset(2)
        }
    }
}

internal enum TagType {
    case cozy
    case crowd
    case diligent
    case emotion
    case soft
    
    var title: String {
        switch self {
        case .cozy:
            return "포근한 해질녘"
        case .crowd:
            return "북적이는 오후"
        case .diligent:
            return "부지런한 동틀녘"
        case .emotion:
            return "감성적인 새벽녘"
        case .soft:
            return "사근한 오전"
        }
    }
    
    var color: UIColor {
        switch self {
        case .cozy:
            return .purple300
        case .crowd:
            return .yellow200
        case .diligent:
            return .pink
        case .emotion:
            return .blue
        case .soft:
            return .orange
        }
    }
}

