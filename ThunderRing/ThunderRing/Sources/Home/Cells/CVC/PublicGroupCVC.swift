//
//  PublicGroupCVC.swift
//  ThunderRing
//
//  Created by HM on 2021/11/23.
//

import UIKit

final class PublicGroupCVC: UICollectionViewCell {
    static let identifier = "PublicGroupCVC"
    
    //MARK: - Properties
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var hashTagImageView: UIImageView!
    @IBOutlet weak var thunderButton: UIButton!
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        backView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 5, bounds: true)
        
        groupImageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: groupImageView.bounds.width / 2, bounds: true)
    }
}

// MARK: - Custom Method

extension PublicGroupCVC {
    func initCell(group: PublicGroupDataModel) {
        groupImageView.image = UIImage(named: group.groupImage)
        
        groupLabel.text = group.groupName
        
        countLabel.text = "\(group.memberCounts)/\(group.memberTotalCounts!)"
        
        switch group.publicGroupType {
        case .diligent:
            hashTagImageView.image = UIImage(named: "tagDiligent")
        case .crowd:
            hashTagImageView.image = UIImage(named: "tagCrowd")
        case .emotion:
            hashTagImageView.image = UIImage(named: "tagEmotion")
        case .soft:
            hashTagImageView.image = UIImage(named: "tagSoft")
        case .cozy:
            hashTagImageView.image = UIImage(named: "tagCozy")
        }
        hashTagImageView.contentMode = .scaleAspectFit
    }
}
