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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
}

extension PrivateGroupTVC {
    private func initUI() {
    
        groupImageView.layer.cornerRadius = groupImageView.bounds.width / 2
        groupImageView.layer.borderWidth = 1
        groupImageView.layer.borderColor = UIColor.gray300.cgColor
    }
}
