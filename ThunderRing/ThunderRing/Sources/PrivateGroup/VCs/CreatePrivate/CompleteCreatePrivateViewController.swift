//
//  CompleteCreateVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/02.
//

import UIKit
 
final class CompleteCreatePrivateViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - Properties
    
    var groupImage = UIImage()
    var groupName = "그룹명"
    var groupDescrption = "그룹 간단 소개"
    var groupCounts = 0
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .background)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
}

extension CompleteCreatePrivateViewController {
    private func initUI() {
        groupImageView.image = self.groupImage
        groupImageView.layer.cornerRadius = 20
        groupImageView.layer.masksToBounds = true
        
        titleLabel.text = "\(groupName)"
        descriptionLabel.text = "\(groupDescrption)"
        
        completeButton.makeRounded(cornerRadius: 43)
    }
    
    private func setAction() {
        completeButton.addAction(UIAction(handler: { _ in
            privateGroupData.append(PrivateGroupDataModel(groupImage: self.groupImage, groupName: self.groupName, memberCounts: self.groupCounts, groupDescription: self.groupDescrption))
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
    }
}
