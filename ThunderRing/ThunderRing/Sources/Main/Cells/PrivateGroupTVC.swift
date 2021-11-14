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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
