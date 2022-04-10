//
//  MyPageLightningCountViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/10.
//

import UIKit

import SnapKit
import Then

final class MyPageLightningCountViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "번개", backButtonIsHidden: false, closeButtonIsHidden: true)
    
    private var historyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .background
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .background
        setStatusBar(.white)
        navigationBar.layer.applyShadow()
    }
    
    private func setLayout() {
        view.addSubviews([historyCollectionView, navigationBar])
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        historyCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        
        historyCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.CellIdentifier)
        historyCollectionView.register(ItemCellHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemCellHeaderView.CellIdentifier)
    }
}

// MARK: - UICollectionView Protocol

extension MyPageLightningCountViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 153)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 57)
    }
}

extension MyPageLightningCountViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // FIXME: - 데이터 변경
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.CellIdentifier, for: indexPath) as? ItemCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemCellHeaderView.CellIdentifier, for: indexPath) as? ItemCellHeaderView else { return UICollectionReusableView() }
        return header
    }
}

// MARK: - Cell

fileprivate final class ItemCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    private lazy var dateLabel = UILabel().then {
        $0.text = "21/08/03"
        $0.textColor = .gray150
        $0.font = .DINPro(type: .regular, size: 14)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "이태원 모각작 모아요"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 14)
    }
    
    private lazy var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_people_small")
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.text = "양파링걸즈"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private lazy var memberImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_people_small")
    }
    
    private lazy var memberCountLabel = UILabel().then {
        $0.text = "4명"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private lazy var locationImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_location_small")
    }
    
    private lazy var locationCountLabel = UILabel().then {
        $0.text = "Zoom 미팅"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        contentView.backgroundColor = .white
        contentView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 10, bounds: true)
    }
    
    private func setLayout() {
        contentView.addSubviews([dateLabel,
                                 titleLabel,
                                 groupImageView,
                                 groupNameLabel,
                                 memberImageView,
                                 memberCountLabel,
                                 locationImageView,
                                 locationCountLabel])
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(13)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(13)
        }
        
        groupImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(20)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(groupImageView.snp.trailing).offset(2)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        memberImageView.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(20)
        }
        
        memberCountLabel.snp.makeConstraints {
            $0.leading.equalTo(memberImageView.snp.trailing).offset(2)
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(7)
        }
        
        locationImageView.snp.makeConstraints {
            $0.top.equalTo(memberImageView.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(20)
        }
        
        locationCountLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImageView.snp.trailing).offset(2)
            $0.top.equalTo(memberCountLabel.snp.bottom).offset(7)
        }
    }
}


// MARK: - Cell Header View

fileprivate final class ItemCellHeaderView: UICollectionReusableView {
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "기록"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var countLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 18)
    }
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
        }
    }
    
    // MARK: - Initialzier
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        backgroundColor = .background
        count = 6
    }
    
    private func setLayout() {
        addSubviews([titleLabel, countLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(14)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.height.equalTo(23)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
    }
}


