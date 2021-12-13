//
//  LookHeaderView.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/14.
//

import UIKit

protocol SortHeaderDelegate {
    func touchUpSort(index: Int)
}

class LookHeaderView: UICollectionReusableView {
    static let identifier = "LookHeaderView"
    
    // MARK: - UI
    
    var sortCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .background
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var sortList = [String]()
    private var selectedIndex = 0
    var sortHeaderDelegate: SortHeaderDelegate?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
        setLayout()
        setData()
        setCollectionView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

extension LookHeaderView {
    private func initUI() {
        self.backgroundColor = .background
    }
    
    private func setLayout() {
        self.addSubview(sortCollectionView)
        
        sortCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(0)
            $0.height.equalTo(88)
        }
    }
    
    private func setData() {
        sortList.append(contentsOf: [
            "# 부지런한 동틀녘", "# 사근한 오전", "# 북적이는 오후", "# 포근한 해질녘", "# 감성적인 새벽녘"
        ])
    }
    
    private func setCollectionView() {
        sortCollectionView.delegate = self
        sortCollectionView.dataSource = self
        
        sortCollectionView.register(LookSortCVC.self, forCellWithReuseIdentifier: LookSortCVC.identifier)
    }
    
    private func setLabelWidth(index: Int) -> CGFloat {
        let label = UILabel()
        label.text = sortList[index]
        label.sizeToFit()
        return label.frame.width + 10 + 10
    }
}

extension LookHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        sortHeaderDelegate?.touchUpSort(index: selectedIndex)
    }
}

extension LookHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: setLabelWidth(index: indexPath.item), height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
    }
}

extension LookHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LookSortCVC.identifier, for: indexPath) as? LookSortCVC else { return UICollectionViewCell() }
        if indexPath.item == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        cell.setLabel(sort: sortList[indexPath.item])
        return cell
    }
}
