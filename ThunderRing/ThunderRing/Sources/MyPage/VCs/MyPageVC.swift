//
//  MyPageVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

class MyPageVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var profileBackView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userInfoView: UIView!
    
    @IBOutlet weak var myPageTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "마이페이지", backBtnIsHidden: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Custom Methods

extension MyPageVC {
    func initUI() {
        
    }
}
