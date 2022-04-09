//
//  LookCollectionViewCellHeaderView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/09.
//

import UIKit

import SnapKit
import Then

final class OverviewCollectionViewCellHeaderView: UICollectionReusableView {
    static let identifier = "OverviewCollectionViewCellHeaderView"
    
    // MARK: - Properties
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: - Initialzier
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        backgroundColor = .background
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(14)
        }
    }
}

