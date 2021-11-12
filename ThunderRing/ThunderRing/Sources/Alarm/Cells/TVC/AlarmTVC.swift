//
//  AlarmTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/10.
//

import UIKit

class AlarmTVC: UITableViewCell {
    static let identifier = "AlarmTVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension AlarmTVC {
    private func initUI() {
        
    }
}
