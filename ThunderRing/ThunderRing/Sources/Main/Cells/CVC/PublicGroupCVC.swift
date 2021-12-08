//
//  PublicGroupCVC.swift
//  ThunderRing
//
//  Created by HM on 2021/11/23.
//

import UIKit

class PublicGroupCVC: UICollectionViewCell {
    
    static let identifier = "PublicGroupCVC"
    
    //MARK: - UI
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var hashTagImageView: UIImageView!
    @IBOutlet weak var thunderButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }

}
// MARK: - Custom Methods

extension PublicGroupCVC {
    private func initUI() {
        backView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 5, bounds: true)
        
        groupImageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: groupImageView.bounds.width / 2, bounds: true)
        
        [groupLabel, countLabel].forEach {
            $0?.addCharacterSpacing()
        }
    }
}

extension PublicGroupCVC {
    func initCell(group: PublicGroupDataModel) {
        groupImageView.image = UIImage(named: group.groupImage)
        
        groupLabel.text = group.groupName
        
        countLabel.text = "\(group.memberCounts)/\(group.memberTotalCounts!)"
        
        switch group.hashTag {
        case "부지런한 동틀녘":
            hashTagImageView.image = UIImage(named: "tagDiligent")
        case "북적이는 오후":
            hashTagImageView.image = UIImage(named: "tagCrowd")
        case "감성적인 새벽녘":
            hashTagImageView.image = UIImage(named: "tagEmotion")
        case "사근한 오전":
            hashTagImageView.image = UIImage(named: "tagSoft")
        case "포근한 해질녘":
            hashTagImageView.image = UIImage(named: "tagCozy")
        default:
            return
        }
        hashTagImageView.contentMode = .scaleAspectFit
    }
}
