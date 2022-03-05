//
//  PrivateGroupCollectionViewCell.swift
//  ThunderRing
//
//  Created by soyeon on 2022/03/04.
//

import UIKit

import SnapKit
import Then

final class HomePrivateGroupCollectionViewCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private lazy var firstCellView = HomePrivateGroupCollectionViewCellView()
    private lazy var lineView = UIView().then {
        $0.backgroundColor = .gray350
    }
    private lazy var secondCellView = HomePrivateGroupCollectionViewCellView()
    
    // MARK: - Initializer
    
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
        
        addSubviews([firstCellView, lineView, secondCellView])
        
        lineView.makeRounded(cornerRadius: 0.5)
    }
    
    private func setLayout() {
        firstCellView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(147)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(firstCellView.snp.bottom)
            $0.height.equalTo(1)
        }
        
        secondCellView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(147)
        }
    }
    
    // MARK: - Custom Method
    
}

