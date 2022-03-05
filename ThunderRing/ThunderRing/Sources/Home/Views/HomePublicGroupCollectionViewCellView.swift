//
//  HomePublicGroupCollectionViewCellView.swift
//  ThunderRing
//
//  Created by soyeon on 2022/03/05.
//

import UIKit

import SnapKit
import Then

final class HomePublicGroupCollectionViewCellView: UIView {
    
    // MARK: - Properties
    
    private lazy var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgJuju")
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "그룹이름"
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 17)
    }
    
    private lazy var memberCountLabel = UILabel().then {
        $0.text = "0/000"
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.text = "그룹상세설명"
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        
    }
    
    private func setLayout() {
        
    }
}

// MARK: - Label

fileprivate enum GroupType {
    case cozy
    case crowd
    case diligent
    case emotion
    case soft
    
    var title: String {
        switch self {
        case .cozy:
            return "#포근한 해질녘"
        case .crowd:
            return "#북적이는 오후"
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
            return UIColor.cozyColor
        case .crowd:
            return UIColor.crowdColor
        case .diligent:
            return UIColor.diligentColor
        case .emotion:
            return UIColor.emotionColor
        case .soft:
            return UIColor.softColor
        }
    }
}
