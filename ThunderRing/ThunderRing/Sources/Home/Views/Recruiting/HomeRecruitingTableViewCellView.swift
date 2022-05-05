//
//  HomeRecruitingView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/09.
//

import UIKit

import SnapKit
import Then

final class HomeRecruitingTableViewCellView: UIView {

    // MARK: - Properties
    
    private lazy var backgroudView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var countLabelView = CountLabelView()
    
    private lazy var locationImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_small_location")
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
            $0.register(HomeRecruitingCollectionViewCell.self,
                        forCellWithReuseIdentifier: HomeRecruitingCollectionViewCell.cellIdentifier)
        }
    }()
        
    private lazy var iconImageView = UIImageView().then {
        $0.image = UIImage(named: "icnPromoter")
    }
    
    private var memberCount: Int = 1
    private var data: LightningDataModel?
    
    // MARK: - Initialzers
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
        setCollectionView()
        getNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .background
        backgroudView.backgroundColor = .white
        
        backgroudView.initViewBorder(borderWidth: 1,
                                     borderColor: UIColor.gray350.cgColor,
                                     cornerRadius: 5,
                                     bounds: true)
    }
    
    private func setLayout() {
        addSubviews([backgroudView, countLabelView])
        
        backgroudView.addSubviews([locationImageView,
                                   subtitleLabel,
                                   titleLabel,
                                   memberCollectionView,
                                   iconImageView])
        
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
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(35)
            $0.width.height.equalTo(20)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationImageView.snp.centerY)
            $0.leading.equalToSuperview().inset(35)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(19)
        }
        
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(53)
            $0.leading.equalToSuperview().inset(50)
            $0.width.height.equalTo(22)
        }
    }
    
    // MARK: - Custom Method
    
    private func setCollectionView() {
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(touchUpJoinButton(_:)), name: NSNotification.Name(Const.Notification.join), object: nil)
    }
    
    internal func initCell(lightning: LightningDataModel) {
        data = lightning
       
        guard let count = lightning.members?.count else { return }
        memberCount = count
        
        titleLabel.text = "\(lightning.groupName) \(lightning.lightningName)"
        titleLabel.setTextSpacingBy(value: -0.6)
        
        subtitleLabel.text = "\(lightning.location) \(lightning.date) \(lightning.time)"
        subtitleLabel.setTextSpacingBy(value: -0.4)
        
        countLabelView.count = lightning.maxNumber - lightning.minNumber
    }
    
    // MARK: - @objc
    
    @objc func touchUpJoinButton(_ notification: Notification) {
        memberCollectionView.reloadData()
    }
}

// MARK: - UICollectionView Protocol

extension HomeRecruitingTableViewCellView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.last != nil) {
            NotificationCenter.default.post(name: NSNotification.Name("TouchUpPlusButton"), object: nil)
        }
    }
}

extension HomeRecruitingTableViewCellView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension HomeRecruitingTableViewCellView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecruitingCollectionViewCell.cellIdentifier, for: indexPath) as? HomeRecruitingCollectionViewCell else { return UICollectionViewCell() }
        
        guard let data = data?.members else { return UICollectionViewCell() }
        cell.initCell(imageName: data[indexPath.item])
        
        if indexPath.item == memberCount - 1 {
            cell.contentView.layer.borderWidth = 0
        }

        return cell
    }
}



