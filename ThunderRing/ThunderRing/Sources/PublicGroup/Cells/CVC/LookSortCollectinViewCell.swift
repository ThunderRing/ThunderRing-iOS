//
//  LookSortCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/12.
//

import UIKit

import SnapKit
import Then

class LookSortCollectinViewCell: UICollectionViewCell {
    static let identifier = "LookSortCollectinViewCell"
    
    // MARK: - Properties
    
    private var sortLabel = UILabel().then {
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        sortLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
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
    
    private func configUI() {
        contentView.addSubview(sortLabel)
        contentView.backgroundColor = .gray350
        contentView.makeRounded(cornerRadius: 13.5)
    }
    
    internal func setLabel(sort: String) {
        sortLabel.text = sort
    }
}

