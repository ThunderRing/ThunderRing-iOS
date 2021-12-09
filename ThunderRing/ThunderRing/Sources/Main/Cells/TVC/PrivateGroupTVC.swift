//
//  PrivateGroupTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/05.
//

import UIKit

class PrivateGroupTVC: UITableViewCell {
    static let identifier = "PrivateGroupTVC"
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupDescriptionLabel: UILabel!
    @IBOutlet weak var countImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var entryButton: UIButton!
    @IBOutlet weak var thunderButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension PrivateGroupTVC {
    private func initUI() {
        groupImageView.layer.cornerRadius = groupImageView.bounds.width / 2
        groupImageView.layer.borderWidth = 1
        groupImageView.layer.borderColor = UIColor.gray300.cgColor
        
        [groupNameLabel, countLabel].forEach {
            $0?.addCharacterSpacing()
        }
    }
}

extension PrivateGroupTVC {
    func initCell(group: PrivateGroupDataModel) {
        groupImageView.image = UIImage(named: group.groupImage)
        groupNameLabel.text = group.groupName
        groupDescriptionLabel.text = group.groupDescription
        countLabel.text = "\(group.memberCounts)"
    }
}
