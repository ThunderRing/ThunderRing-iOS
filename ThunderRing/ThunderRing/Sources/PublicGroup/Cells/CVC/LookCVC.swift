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
    }
    
    private func setData() {
        lookGroups.append(contentsOf: [
            PublicGroupDataModel(groupImage: "imgRice", groupName: "Rice ball", memberCounts: 4, hashTag: "부지런한 동틀녁", memberTotalCounts: 100),
            PublicGroupDataModel(groupImage: "imgBear", groupName: "곰돌아이", memberCounts: 4, hashTag: "북적이는 오후", memberTotalCounts: 10),
            PublicGroupDataModel(groupImage: "imgNintendo", groupName: "동물의 숲", memberCounts: 3, hashTag: "감성적인 새벽녘", memberTotalCounts: 30),
            PublicGroupDataModel(groupImage: "imgDog", groupName: "이지언니", memberCounts: 4, hashTag: "사근한 오전", memberTotalCounts: 300)
        ])
    }
}

extension LookCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 25 - 25 - 11) / 2
        let division = CGFloat(lookGroups.count / 2)
        let cellHeight = (collectionView.frame.height - 88 - (11 * division)) / division
        return CGSize(width: cellWidth, height: cellHeight)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 88, left: 25, bottom: 0, right: 25)
    }
}

extension LookCVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lookGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LookDetailCVC.identifier, for: indexPath) as? LookDetailCVC else { return UICollectionViewCell() }
        return cell
    }
}
