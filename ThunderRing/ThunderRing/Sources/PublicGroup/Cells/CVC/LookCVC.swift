//
//  LookCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/10.
//

import UIKit

class LookCVC: UICollectionViewCell {
    static let identifier = "LookCVC"
    
    // MARK: - UI
    
    @IBOutlet weak var groupCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var lookGroups = [PublicGroupDataModel]()

    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        setCollectionView()
        setData()
    }

}

extension LookCVC {
    private func initUI() {
        self.backgroundColor = .background
    }
    
    private func setCollectionView() {
        groupCollectionView.delegate = self
        groupCollectionView.dataSource = self
        
        groupCollectionView.backgroundColor = .background
        
        groupCollectionView.register(LookDetailCVC.self, forCellWithReuseIdentifier: LookDetailCVC.identifier)
        groupCollectionView.register(LookHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: LookHeaderView.identifier)
    }
    
    private func setData() {
        lookGroups.append(contentsOf: [
            PublicGroupDataModel(groupImage: "imgDrama", groupName: "드라마 같이 봐요", memberCounts: 11, hashTag: "부지런한 동틀녘", memberTotalCounts: 100),
            PublicGroupDataModel(groupImage: "imgBear1", groupName: "줌으로 같이 공부", memberCounts: 4, hashTag: "북적이는 오후", memberTotalCounts: 10),
            PublicGroupDataModel(groupImage: "imgCatch", groupName: "캐치마인드", memberCounts: 10, hashTag: "부지런한 동틀녘", memberTotalCounts: 160),
            PublicGroupDataModel(groupImage: "imgRun", groupName: "러닝크루", memberCounts: 8, hashTag: "감성적인 새벽녘", memberTotalCounts: 10),
            PublicGroupDataModel(groupImage: "imgCoin", groupName: "주식 스터디", memberCounts: 8, hashTag: "북적이는 오후", memberTotalCounts: 10),
            PublicGroupDataModel(groupImage: "imgNeedle", groupName: "펀치니들 배워요", memberCounts: 10, hashTag: "감성적인 새벽녘", memberTotalCounts: 160)
        ])
    }
}

extension LookCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 25 - 25 - 11) / 2
        let division = CGFloat(lookGroups.count / 2) - 1
        let cellHeight = (collectionView.frame.height - (11 * division)) / (division + 1)
        // MARK: - FIX ME
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

extension LookCVC: SortHeaderDelegate {
    func touchUpSort(index: Int) {

        lookGroups.removeAll()
        
        switch index {
        case 0:
            lookGroups.append(contentsOf: [
                PublicGroupDataModel(groupImage: "imgDrama", groupName: "드라마 같이 봐요", memberCounts: 11, hashTag: "부지런한 동틀녘", memberTotalCounts: 100),
                PublicGroupDataModel(groupImage: "imgBear1", groupName: "줌으로 같이 공부", memberCounts: 4, hashTag: "부지런한 동틀녘", memberTotalCounts: 10),
                PublicGroupDataModel(groupImage: "imgCatch", groupName: "캐치마인드", memberCounts: 10, hashTag: "부지런한 동틀녘", memberTotalCounts: 160),
                PublicGroupDataModel(groupImage: "imgRun", groupName: "러닝크루", memberCounts: 8, hashTag: "부지런한 동틀녘", memberTotalCounts: 10),
                PublicGroupDataModel(groupImage: "imgCoin", groupName: "주식 스터디", memberCounts: 8, hashTag: "부지런한 동틀녘", memberTotalCounts: 10),
                PublicGroupDataModel(groupImage: "imgNeedle", groupName: "펀치니들 배워요", memberCounts: 10, hashTag: "부지런한 동틀녘", memberTotalCounts: 160)
            ])
        case 1:
            lookGroups.append(contentsOf: [
                PublicGroupDataModel(groupImage: "imgDog", groupName: "캐치마인드", memberCounts: 4, hashTag: "사근한 오전", memberTotalCounts: 100),
                PublicGroupDataModel(groupImage: "imgRice", groupName: "공부모임", memberCounts: 4, hashTag: "사근한 오전", memberTotalCounts: 10)
            ])
        case 2:
            lookGroups.append(contentsOf: [
                PublicGroupDataModel(groupImage: "imgNintendo", groupName: "캐치마인드", memberCounts: 4, hashTag: "북적이는 오후", memberTotalCounts: 100),
                PublicGroupDataModel(groupImage: "imgBear", groupName: "공부모임", memberCounts: 4, hashTag: "북적이는 오후", memberTotalCounts: 10),
                PublicGroupDataModel(groupImage: "imgDog", groupName: "아쿠아맨", memberCounts: 3, hashTag: "북적이는 오후", memberTotalCounts: 30)
            ])
        case 3:
            lookGroups.append(contentsOf: [
                PublicGroupDataModel(groupImage: "imgDog", groupName: "캐치마인드", memberCounts: 4, hashTag: "포근한 해질녘", memberTotalCounts: 100),
                PublicGroupDataModel(groupImage: "imgBear", groupName: "공부모임", memberCounts: 4, hashTag: "포근한 해질녘", memberTotalCounts: 10)
            ])
        default :
            lookGroups.append(contentsOf: [
                PublicGroupDataModel(groupImage: "imgRice", groupName: "캐치마인드", memberCounts: 4, hashTag: "감성적인 새벽녘", memberTotalCounts: 100),
                PublicGroupDataModel(groupImage: "imgNintendo", groupName: "공부모임", memberCounts: 4, hashTag: "감성적인 새벽녘", memberTotalCounts: 10)
            ])
            
        }
        
        groupCollectionView.reloadData()
        
    }
}
