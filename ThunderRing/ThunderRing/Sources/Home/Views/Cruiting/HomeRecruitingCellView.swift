//
//  HomeRecruitingView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/09.
//

import UIKit

import SnapKit
import Then

final class HomeRecruitingCellView: UIView {

    // MARK: - Properties
    
    private lazy var backgroudView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var countLabelView = CountLabelView()
    
    private lazy var locationImageView = UIImageView().then {
        $0.image = UIImage(named: "icnLocation")
    }
    
    private lazy var subtitleLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var memberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.showsHorizontalScrollIndicator = false
        }
    }()
    
    private var memberCount: Int = 1
    
    // MARK: - Initialzers
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
        
        backgroudView.initViewBorder(borderWidth: 1,
                                     borderColor: UIColor.gray350.cgColor,
                                     cornerRadius: 5,
                                     bounds: true)
        
        addSubviews([backgroudView, countLabelView])
        
        backgroudView.addSubviews([locationImageView,
                                   subtitleLabel,
                                   titleLabel,
                                   memberCollectionView])
    }
    
    private func setLayout() {
        backgroudView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.top.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        countLabelView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(45)
            $0.width.equalTo(98)
            $0.height.equalTo(31)
        }
        
        locationImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(19)
            $0.top.equalToSuperview().inset(36)
            $0.width.equalTo(10)
            $0.height.equalTo(15)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationImageView.snp.centerY)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(19)
        }
        
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        
    }
    
    internal func configCell(lightning: LightningDataModel) {
        titleLabel.text = "\(lightning.groupName) \(lightning.lightningName)"
        subtitleLabel.text = "\(lightning.location) \(lightning.date) \(lightning.time)"
        
        countLabelView.count = lightning.maxNumber - lightning.minNumber
    }
}

// MARK: - Custom View

fileprivate final class CountLabelView: UIView {
    
    var count: Int = 0 {
        didSet {
            titleLabel.text = "잔여 \(count)자리"
        }
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
    }
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .purple100
        makeRounded(cornerRadius: 15.5)
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
