//
//  AlarmTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/10.
//

import UIKit

final class AlarmTVC: UITableViewCell {
    static let identifier = "AlarmTVC"
    
    // MARK: - Properties
    
    @IBOutlet weak var backView: UIView!

    @IBOutlet weak var hashTagBackViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var hashTagBackView: UIView!
    @IBOutlet weak var hashTagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var markImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    // MARK: - Init UI
    
    private func configUI() {
        backView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 12, bounds: true)
        hashTagBackView.initViewBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 9.5, bounds: true)
    }
    
    // MARK: - Custom Method
    
    func initCell(alarmType: AlarmType, title: String, description: String, time: String, hashTag: String) {
        hashTagLabel.text = hashTag
        titleLabel.text = title
        descriptionLabel.text = description
        timeLabel.text = time
        
        hashTagBackViewWidth.constant = calculateCellWidth(text: hashTag)
        contentView.layoutSubviews()
        
        switch alarmType {
        case .thunder:
            if let image = UIImage(named: "icnAlarmThunder") {
                markImageView.image = image
            }
        case .lightning:
            if let image = UIImage(named: "icnAlarmLight") {
                markImageView.image = image
            }
        case .failed:
            if let image = UIImage(named: "iconAlarmCancel") {
                markImageView.image = image
            }
        }
        markImageView.contentMode = .scaleAspectFill
    }
    
    private func calculateCellWidth(text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = .SpoqaHanSansNeo(type: .regular, size: 12)
        label.sizeToFit()
        return label.frame.width + 16
    }
}
