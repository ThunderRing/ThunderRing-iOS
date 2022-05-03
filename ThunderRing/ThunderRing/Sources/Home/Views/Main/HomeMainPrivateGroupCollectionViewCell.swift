//
//  PrivateGroupCollectionViewCell.swift
//  ThunderRing
//
//  Created by soyeon on 2022/03/04.
//

import UIKit

import SnapKit
import Then

final class HomeMainPrivateGroupCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    var firstCellView = HomeMainPrivateGroupCollectionViewCellView()
    private lazy var lineView = UIView().then {
        $0.backgroundColor = .gray350
    }
    var secondCellView = HomeMainPrivateGroupCollectionViewCellView()
    
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
        backgroundColor = .white
        
        contentView.addSubview(firstCellView)
        contentView.addSubview(lineView)
        contentView.addSubview(secondCellView)

        contentView.initViewBorder(borderWidth: 1,
                                   borderColor: UIColor.gray350.cgColor,
                                   cornerRadius: 5,
                                   bounds: true)
        lineView.makeRounded(cornerRadius: 0.5)
    }
    
    private func setLayout() {
        firstCellView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(147)
        }
        
        lineView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(11)
            $0.height.equalTo(1)
        }
        
        secondCellView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(147)
        }
    }
    
    // MARK: - Custom Method
    
    internal func initCell(firstGroup: PrivateGroupData, secondGroup: PrivateGroupData) {
        firstCellView.configCell(group: firstGroup)
        secondCellView.configCell(group: secondGroup)
    }
}

