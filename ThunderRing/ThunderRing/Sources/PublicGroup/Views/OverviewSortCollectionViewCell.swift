//
//  LookSortCVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/12/12.
//

import UIKit

import SnapKit
import Then

final class OverviewSortCollectionViewCell: UICollectionViewCell {
    static let identifier = "OverviewSortCollectionViewCell"
    
    // MARK: - Properties
    
    private var sortLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    // MARK: - Initialzier
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .purple100
                sortLabel.textColor = .white
            } else {
                contentView.backgroundColor = .gray350
                sortLabel.textColor = .gray100
            }
        }
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        contentView.backgroundColor = .gray350
        contentView.makeRounded(cornerRadius: 13.5)
    }
    
    private func setLayout() {
        contentView.addSubview(sortLabel)
        sortLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Custom
    
    internal func setLabel(sort: String) {
        sortLabel.text = sort
    }
}

