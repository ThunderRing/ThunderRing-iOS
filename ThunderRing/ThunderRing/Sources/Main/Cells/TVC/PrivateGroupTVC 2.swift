//
//  PrivateGroupTVC.swift
//  ThunderRing
//
//  Created by HM on 2021/11/14.
//

import UIKit

class PrivateGroupTVC: UITableViewCell {
    static let identifier = "PrivateGroupTVC"
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupExplainLabel: UILabel!
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
    }
}

extension PrivateGroupTVC {
    func initCell(group: PrivateGroupDataModel) {
        groupImageView.image = UIImage(named: group.groupImage)
        groupNameLabel.text = group.groupName
        groupExplainLabel.text = group.groupDescription
    }
}
