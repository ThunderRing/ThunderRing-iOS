//
//  AlarmTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/10.
//

import UIKit

class AlarmTVC: UITableViewCell {
    static let identifier = "AlarmTVC"
    
    // MARK: - UI
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var hashTagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var markImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Custom Methods

extension AlarmTVC {
    private func initUI() {
        backView.layer.borderColor = UIColor.gray.cgColor
        backView.layer.borderWidth = 1
        
        backView.layer.cornerRadius = 12
        backView.layer.masksToBounds = true
        
        if let image = UIImage(named: "Mark_Chatbook") {
            markImageView.image = image
        }
        markImageView.contentMode = .scaleAspectFill
        
    }
}
