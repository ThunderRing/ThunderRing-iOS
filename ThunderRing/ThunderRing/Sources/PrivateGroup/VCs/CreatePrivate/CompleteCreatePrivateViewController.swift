//
//  CompleteCreatePrivateViewController.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/02.
//

import UIKit
 
final class CompleteCreatePrivateViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    
    var groupImage = UIImage()
    var groupName = "그룹명"
    var groupDescrption = "그룹 간단 소개"
    var groupCounts = 0
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: false, closeBtnIsHidden: false, bgColor: .background)
        setStatusBar(.background)
        
        groupImageView.image = self.groupImage
        groupImageView.makeRounded(cornerRadius: 20)
        
        titleLabel.text = "\(groupName)"
        descriptionLabel.text = "\(groupDescrption)"
        
        completeButton.makeRounded(cornerRadius: 26)
        completeButton.backgroundColor = .purple100
        completeButton.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - Custom Method
    
    private func setAction() {
        completeButton.addAction(UIAction(handler: { _ in
            privateGroupData.append(PrivateGroupDataModel(groupImage: self.groupImage, groupName: self.groupName, memberCounts: self.groupCounts, groupDescription: self.groupDescrption))
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
    }
}
