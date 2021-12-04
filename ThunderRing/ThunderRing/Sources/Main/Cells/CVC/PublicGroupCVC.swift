//
//  PublicGroupCVC.swift
//  ThunderRing
//
//  Created by HM on 2021/11/23.
//

import UIKit

class PublicGroupCVC: UICollectionViewCell {
    
    static let identifier = "PublicGroupCVC"
    
    //MARK: - UI
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var hashTagImageView: UIImageView!
    @IBOutlet weak var thunderButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initUI()
    }

}
// MARK: - Custom Methods

extension PublicGroupCVC {
    
    private func initUI() {
        
        backView.layer.borderWidth = 1
        backView.layer.cornerRadius = 5
        backView.layer.borderColor = UIColor.gray300.cgColor
        
        groupImageView.layer.cornerRadius = groupImageView.bounds.width / 2
        groupImageView.layer.borderWidth = 1
        groupImageView.layer.borderColor = UIColor.gray300.cgColor

    }
}
