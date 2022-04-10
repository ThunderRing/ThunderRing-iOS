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
        $0.image = UIImage(named: "icn_location")
    }
    
    private lazy var subtitleLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
        $0.addCharacterSpacing(kernValue: -0.4, paragraphValue: 4)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
        $0.addCharacterSpacing()
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
                        forCellWithReuseIdentifier: HomeRecruitingCollectionViewCell.CellIdentifier)
        }
    }()
    
    private lazy var plusButton = PlusButton()
        
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
                                   memberCollectionView,
                                   plusButton,
                                   iconImageView])
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
        
        plusButton.snp.makeConstraints {
            $0.leading.equalTo(memberCollectionView.snp.trailing).offset(-50)
            $0.centerY.equalTo(memberCollectionView.snp.centerY)
            $0.width.equalTo(48)
            $0.height.equalTo(50)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(53)
            $0.leading.equalToSuperview().inset(50)
            $0.width.height.equalTo(22)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(touchUpJoinButton(_:)), name: NSNotification.Name(Const.Notification.join), object: nil)
    }
    
    internal func configCell(lightning: LightningDataModel) {
        data = lightning
       
        guard let count = lightning.members?.count else { return }
        memberCount = count
        
        titleLabel.text = "\(lightning.groupName) \(lightning.lightningName)"
        subtitleLabel.text = "\(lightning.location) \(lightning.date) \(lightning.time)"
        
        countLabelView.count = lightning.maxNumber - lightning.minNumber
    }
    
    @objc func touchUpJoinButton(_ notification: Notification) {
        memberCollectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate

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

// MARK: - UICollectionView DataSource

extension HomeRecruitingTableViewCellView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecruitingCollectionViewCell.CellIdentifier, for: indexPath) as? HomeRecruitingCollectionViewCell else { return UICollectionViewCell() }
        guard let data = data?.members else { return UICollectionViewCell() }
        cell.initCell(imageName: data[indexPath.item])
        return cell
    }
}


// MARK: - Custom Component

fileprivate final class CountLabelView: UIView {
    var count: Int = 0 {
        didSet {
            titleLabel.text = "잔여 \(count)자리"
        }
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
        $0.addCharacterSpacing()
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

fileprivate final class PlusButton: UIButton {
    private var plusImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_plus")
    }
    
    init() {
        super.init(frame: .zero)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        addTarget(self, action: #selector(touchUpPlusButton), for: .touchUpInside)
        
        initViewBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 15, bounds: true)
        addSubview(plusImageView)
        plusImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(18)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpPlusButton() {
        NotificationCenter.default.post(name: NSNotification.Name("TouchUpPlusButton"), object: nil)
    }
}

