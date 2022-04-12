//
//  MyOverviewCollectionViewCell.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/09.
//

import UIKit

import SnapKit
import Then

final class MyOverviewCollectionViewCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    private lazy var contentScrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.isPagingEnabled = false
    }
    
    private lazy var contentBackView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private var sortCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .background
        return collectionView
    }()
    
    private var groupCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .background
        return collectionView
    }()
    
    private var sortList = [String]()
    private var selectedIndex = 0
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        backgroundColor = .background
    }
    
    private func setLayout() {
        addSubview(contentScrollView)
        contentScrollView.addSubview(contentBackView)
        contentBackView.addSubviews([sortCollectionView, groupCollectionView])
        
        contentScrollView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        contentBackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        sortCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(27)
        }
        
        groupCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortCollectionView.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1723)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        sortList.append(contentsOf: [
            "전체", "부지런한 동틀녘", "사근한 오전", "북적이는 오후", "포근한 해질녘", "감성적인 새벽녘"
        ])
        
        sortCollectionView.delegate = self
        sortCollectionView.dataSource = self
        sortCollectionView.register(OverviewSortCollectionViewCell.self, forCellWithReuseIdentifier: OverviewSortCollectionViewCell.identifier)
        
        groupCollectionView.delegate = self
        groupCollectionView.dataSource = self
        groupCollectionView.register(OverviewCollectionViewCell.self, forCellWithReuseIdentifier: OverviewCollectionViewCell.identifier)
        groupCollectionView.register(OverviewCollectionViewCellHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OverviewCollectionViewCellHeaderView.identifier)
    }
    
    private func setLabelWidth(index: Int) -> CGFloat {
        let label = UILabel()
        label.text = sortList[index]
        label.sizeToFit()
        label.setTextSpacingBy(value: -0.6)
        return label.frame.width + 10 + 10
    }
}

// MARK: - UICollectionView Delegate

extension MyOverviewCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sortCollectionView {
            selectedIndex = indexPath.item
            collectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - UICollectionView DelegateFlowLayout

extension MyOverviewCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sortCollectionView {
            return CGSize(width: setLabelWidth(index: indexPath.item), height: 27)
        } else {
            return CGSize(width: 158, height: 182)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sortCollectionView {
            return 8
        } else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sortCollectionView {
            return 8
        } else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == sortCollectionView {
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        } else {
            return UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == groupCollectionView {
            return CGSize(width: collectionView.frame.width, height: 58)
        } else {
            return .zero
        }
    }
}

// MARK: - UICollectionView DataSource

extension MyOverviewCollectionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == groupCollectionView {
            return 3
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case sortCollectionView:
            return sortList.count
        case groupCollectionView:
            if section == 0 {
                return publicGroupData.count
            } else if section == 1 {
                return publicGroupData.count
            } else {
                return publicGroupData.count
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case sortCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverviewSortCollectionViewCell.identifier, for: indexPath) as? OverviewSortCollectionViewCell else { return UICollectionViewCell() }
            cell.setLabel(sort: sortList[indexPath.item])
            if indexPath.row == 0 {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            } else {
                cell.isSelected = false
            }
            return cell
        case groupCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverviewCollectionViewCell.identifier, for: indexPath) as? OverviewCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(group: publicGroupData[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == groupCollectionView {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OverviewCollectionViewCellHeaderView.identifier, for: indexPath) as? OverviewCollectionViewCellHeaderView else { return UICollectionReusableView() }
            if indexPath.section == 0 {
                header.title = "이런 액티비티 어때요?"
            } else if indexPath.section == 1 {
                header.title = "인기 맛집 탐방"
            } else {
                header.title = "그리운 동창"
            }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}


