//
//  LookSortCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/12.
//

import UIKit

class LookSortCVC: UICollectionViewCell {
    static let identifier = "LookSortCVC"
    
    // MARK: - UI
    
    private var sortLabel = UILabel().then {
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
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
                layer.backgroundColor = UIColor.purple100.cgColor
                sortLabel.textColor = .white
            } else {
                layer.backgroundColor = UIColor.background.cgColor
                sortLabel.textColor = .purple100
            }
        }
    }
}

extension LookSortCVC {
    private func initUI() {
        contentView.addSubview(sortLabel)
        
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.purple100.cgColor
    }
    
    private func setAction() {
        
    }
}

extension LookSortCVC {
    func setLabel(sort: String) {
        sortLabel.text = sort
    }
}

