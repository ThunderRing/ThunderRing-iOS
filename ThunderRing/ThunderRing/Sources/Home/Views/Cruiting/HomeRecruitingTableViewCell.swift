//
//  HomeCruitingTableViewCell.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/09.
//

import UIKit

import SnapKit
import Then

final class HomeRecruitingTableViewCell: UITableViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private lazy var cellView = HomeRecruitingCellView()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    // MARK: - Public Method
    
    internal func initCell(lightning: LightningDataModel) {
        cellView.configCell(lightning: lightning)
    }
}
