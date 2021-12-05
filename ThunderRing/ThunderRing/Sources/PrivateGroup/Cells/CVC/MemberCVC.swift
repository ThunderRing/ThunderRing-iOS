//
//  MemberCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/02.
//

import UIKit

import SnapKit
import Then

class MemberCVC: UICollectionViewCell {
    static let identifier = "MemberCVC"
    
    // MARK: - UI
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        label.textColor = UIColor.purple100
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                nameLabel.textColor = UIColor.purple100
            } else {
                nameLabel.textColor = UIColor.gray200
            }
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Custom Methods

extension MemberCVC {
    func setLayout() {
        contentView.addSubviews([nameLabel])
        contentView.initViewBorder(borderWidth: 2, borderColor: UIColor.purple100.cgColor, cornerRadius: 40, bounds: true)

        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

extension MemberCVC {
    func initCell(name: String) {
        nameLabel.text = name
        nameLabel.sizeToFit()
    }
}
