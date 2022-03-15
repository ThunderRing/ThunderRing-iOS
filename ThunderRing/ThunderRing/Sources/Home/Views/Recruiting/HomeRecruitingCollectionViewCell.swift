//
//  HomeCruitingCollectionViewCell.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/10.
//

import UIKit

import SnapKit
import Then

final class HomeRecruitingCollectionViewCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    private var memberImageView = UIImageView().then {
        $0.image = UIImage(named: "imgFlog")
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
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.addSubview(memberImageView)
        contentView.makeRounded(cornerRadius: 15)
    }
    
    private func setLayout() {
        memberImageView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    internal func initCell(imageName: String) {
        memberImageView.image = UIImage(named: imageName)
    }
}


