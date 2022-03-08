//
//  HomeCruitingTableViewCell.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/09.
//

import UIKit

import SnapKit
import Then

final class HomeCruitingTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        
    }
}
