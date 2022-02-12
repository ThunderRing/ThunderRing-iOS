//
//  LookCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/10.
//

import UIKit

final class LookCVC: UICollectionViewCell {
    static let identifier = "LookCVC"
    
    // MARK: - Properties
    
    @IBOutlet weak var groupCollectionView: UICollectionView!
    
    private var lookGroups = [PublicGroupDataModel]()

    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        setCollectionView()
        setData()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        backgroundColor = .background
    }
    
    // MARK: - Custom Method
    
    private func setCollectionView() {
        groupCollectionView.delegate = self
        groupCollectionView.dataSource = self
        
        groupCollectionView.backgroundColor = .background
        
        groupCollectionView.register(LookDetailCVC.self, forCellWithReuseIdentifier: LookDetailCVC.identifier)
        groupCollectionView.register(LookHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: LookHeaderView.identifier)
    }
    
    private func setData() {
        lookGroups.append(contentsOf: [
            PublicGroupDataModel(groupImage: "imgDrama", groupName: "드라마 같이 봐요", memberCounts: 11, publicGroupType: .diligent, memberTotalCounts: 100),
            PublicGroupDataModel(groupImage: "imgBear1", groupName: "줌으로 같이 공부", memberCounts: 4, publicGroupType: .crowd, memberTotalCounts: 10),
            PublicGroupDataModel(groupImage: "imgCatch", groupName: "캐치마인드", memberCounts: 10, publicGroupType: .diligent, memberTotalCounts: 160),
            PublicGroupDataModel(groupImage: "imgRun", groupName: "러닝크루", memberCounts: 8, publicGroupType: .emotion, memberTotalCounts: 10),
            PublicGroupDataModel(groupImage: "imgCoin", groupName: "주식 스터디", memberCounts: 8, publicGroupType: .crowd, memberTotalCounts: 10),
            PublicGroupDataModel(groupImage: "imgNeedle", groupName: "펀치니들 배워요", memberCounts: 10, publicGroupType: .emotion, memberTotalCounts: 160)
        ])
    }
}

// MARK: - UICollectionView Delegate

extension LookCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 25 - 25 - 11) / 2
        let division = CGFloat(lookGroups.count / 2) - 1
        // FIXME: - size 동적으로 변화 
        return CGSize(width: cellWidth, height: 209)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 25, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LookHeaderView", for: indexPath) as? LookHeaderView else { return UICollectionReusableView() }
        view.sortHeaderDelegate = self
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 88)
    }
}

// MARK: - UICollectionView DataSource

extension LookCVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lookGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LookDetailCVC.identifier, for: indexPath) as? LookDetailCVC else { return UICollectionViewCell() }
        cell.initCell(group: lookGroups[indexPath.item])
        return cell
    }
}

// MARK: - Custom Delegate

extension LookCVC: SortHeaderDelegate {
    func touchUpSort(index: Int) {
        lookGroups.removeAll()
        switch index {
        case 0:
            lookGroups.append(contentsOf: [
                PublicGroupDataModel(groupImage: "imgDrama", groupName: "드라마 같이 봐요", memberCounts: 11, publicGroupType: .diligent, memberTotalCounts: 100),
                PublicGroupDataModel(groupImage: "imgBear1", groupName: "줌으로 같이 공부", memberCounts: 4, publicGroupType: .diligent, memberTotalCounts: 10),
                PublicGroupDataModel(groupImage: "imgCatch", groupName: "캐치마인드", memberCounts: 10, publicGroupType: .diligent, memberTotalCounts: 160),
                PublicGroupDataModel(groupImage: "imgRun", groupName: "러닝크루", memberCounts: 8, publicGroupType: .diligent, memberTotalCounts: 10),
                PublicGroupDataModel(groupImage: "imgCoin", groupName: "주식 스터디", memberCounts: 8, publicGroupType: .diligent, memberTotalCounts: 10),
                PublicGroupDataModel(groupImage: "imgNeedle", groupName: "펀치니들 배워요", memberCounts: 10, publicGroupType: .diligent, memberTotalCounts: 160)
            ])
        case 1:
            lookGroups.append(contentsOf: [
                PublicGroupDataModel(groupImage: "imgDog", groupName: "캐치마인드", memberCounts: 4, publicGroupType: .soft, memberTotalCounts: 100),
                PublicGroupDataModel(groupImage: "imgRice", groupName: "공부모임", memberCounts: 4, publicGroupType: .soft, memberTotalCounts: 10)
            ])
        case 2:
            lookGroups.append(contentsOf: [
                PublicGroupDataModel(groupImage: "imgNintendo", groupName: "캐치마인드", memberCounts: 4, publicGroupType: .crowd, memberTotalCounts: 100),
                PublicGroupDataModel(groupImage: "imgBear", groupName: "공부모임", memberCounts: 4, publicGroupType: .crowd, memberTotalCounts: 10),
                PublicGroupDataModel(groupImage: "imgDog", groupName: "아쿠아맨", memberCounts: 3, publicGroupType: .crowd, memberTotalCounts: 30)
            ])
        case 3:
            lookGroups.append(contentsOf: [
                PublicGroupDataModel(groupImage: "imgDog", groupName: "캐치마인드", memberCounts: 4, publicGroupType: .cozy, memberTotalCounts: 100),
                PublicGroupDataModel(groupImage: "imgBear", groupName: "공부모임", memberCounts: 4, publicGroupType: .cozy, memberTotalCounts: 10)
            ])
        default :
            lookGroups.append(contentsOf: [
                PublicGroupDataModel(groupImage: "imgRice", groupName: "캐치마인드", memberCounts: 4, publicGroupType: .emotion, memberTotalCounts: 100),
                PublicGroupDataModel(groupImage: "imgNintendo", groupName: "공부모임", memberCounts: 4, publicGroupType: .emotion, memberTotalCounts: 10)
            ])
        }
        groupCollectionView.reloadData()
    }
}
