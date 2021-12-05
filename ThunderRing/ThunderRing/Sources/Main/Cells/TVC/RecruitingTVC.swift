//
//  RecruitingTVC.swift
//  ThunderRing
//
//  Created by HM on 2021/11/28.
//

import UIKit

class RecruitingTVC: UITableViewCell {
    
    static let identifier = "RecruitingTVC"

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var groupTitleLabel: UILabel!
    
    @IBOutlet weak var recruiterImageView: UIImageView!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var remainView: UIView!
    @IBOutlet weak var remainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25))
    }
    
}

// MARK: - UI

extension RecruitingTVC {
    func initUI() {
        
        backView.layer.cornerRadius = 5
        backView.layer.borderColor = UIColor.gray300.cgColor
        backView.layer.borderWidth = 1
        
        recruiterImageView.layer.cornerRadius = recruiterImageView.bounds.width / 2
        
        remainView.layer.cornerRadius = 15
    }
}
