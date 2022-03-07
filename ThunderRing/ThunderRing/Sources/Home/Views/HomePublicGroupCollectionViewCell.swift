//
//  PublicGroupCollectionViewCell.swift
//  ThunderRing
//
//  Created by soyeon on 2022/03/05.
//

import UIKit

import SnapKit
import Then

final class HomePublicGroupCollectionViewCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private lazy var cellView = HomePublicGroupCollectionViewCellView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .background
        contentView.addSubview(cellView)
        contentView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 5, bounds: true)
    }
    
    private func setLayout() {
        cellView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func initCell(group: PublicGroupDataModel) {
        cellView.configCell(group: group)
    }
}

