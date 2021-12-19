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
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var recruitingTitleLabel: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var remainView: UIView!
    @IBOutlet weak var remainCountLabel: UILabel!
    
    @IBOutlet weak var memberStackView: UIStackView!
    
    // MARK: - Properties
    
    var recruitingDelegate: RecruitingCellDelegate?
    private var remainCount: Int?
    
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
        
        memberStackView.spacing = 15
        remainView.layer.cornerRadius = 15
        
        [recruitingTitleLabel, remainCountLabel].forEach {
            $0?.addCharacterSpacing()
        }
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
        
        memberStackView.spacing = 15
        memberStackView.addArrangedSubview(userImageView)
        
        if let count = self.remainCount {
            remainCountLabel.text = "잔여 \(count - 1)자리"
        }
        
        plusButton.isHidden = true
    }
}

extension RecruitingTVC {
    func initCell(lightning: LightningDataModel) {
        self.remainCount = lightning.maxNumber - (lightning.members?.count ?? 1)
        self.remainCountLabel.text = "잔여 \(remainCount!)자리"
        
//        if lightning.members?.count == 0 {
//            let count = 1
//            self.remainCountLabel.text = "잔여 \(String(lightning.maxNumber - count))자리"
//        } else {
//            self.remainCountLabel.text = "잔여 \(String(lightning.maxNumber - lightning.members!.count))자리"
//        }
        
        self.detailLabel.text = "\(lightning.location) \(lightning.date) \(lightning.time)"
        self.recruitingTitleLabel.text = "[\(lightning.groupName)]" + " \(lightning.lightningName)"
    }
}
