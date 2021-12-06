//
//  RecruitingTVC.swift
//  ThunderRing
//
//  Created by HM on 2021/11/28.
//

import UIKit

protocol RecruitingCellDelegate {
    func touchUpPlus()
}

class RecruitingTVC: UITableViewCell {
    
    static let identifier = "RecruitingTVC"

    // MARK: - UI
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var groupTitleLabel: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var remainView: UIView!
    @IBOutlet weak var remainLabel: UILabel!
    
    @IBOutlet weak var memberStackView: UIStackView!
    
    // MARK: - Properties
    
    var recruitingDelegate : RecruitingCellDelegate?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        setAction()
        getNotification()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - UI

extension RecruitingTVC {
    private func initUI() {
        backView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 5, bounds: true)
        
        memberStackView.spacing = 8
        remainView.layer.cornerRadius = 15
    }
    
    private func setAction() {
        plusButton.addAction(UIAction(handler: { _ in
            self.recruitingDelegate?.touchUpPlus()
        }), for: .touchUpInside)
    }
}

// MARK: - Notification

extension RecruitingTVC {
    func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(addMember(_:)), name: NSNotification.Name("AddMember"), object: nil)
    }
    
    @objc
    func addMember(_ notification: Notification) {
        let userImageView = UIImageView()
        userImageView.image = UIImage(named: "imgUser3")
        
        memberStackView.spacing = 8
        memberStackView.addArrangedSubview(userImageView)
    }
}
