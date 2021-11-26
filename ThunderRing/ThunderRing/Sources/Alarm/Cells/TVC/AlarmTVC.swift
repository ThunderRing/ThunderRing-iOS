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
    @IBOutlet weak var descriptionLabel: UILabel!
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
        backView.initViewBorder(borderWidth: 1, borderColor: UIColor.grayStroke.cgColor, cornerRadius: 12, bounds: true)
    }
}

extension AlarmTVC {
    func initCell(isThunder: Bool, isLightning: Bool, isFailed: Bool, title: String, description: String, time: String, hashTag: String) {
        hashTagLabel.text = hashTag
        titleLabel.text = title
        descriptionLabel.text = description
        timeLabel.text = time
        
        if isThunder {
            if let image = UIImage(named: "Mark_Chatbook") {
                markImageView.image = image
            }
            markImageView.contentMode = .scaleAspectFill
        }
        if isLightning {
            if let image = UIImage(named: " ") {
                markImageView.image = image
            }
            markImageView.contentMode = .scaleAspectFill
        }
        if isFailed {
            if let image = UIImage(named: " ") {
                markImageView.image = image
            }
            markImageView.contentMode = .scaleAspectFill
        }
    }
}
