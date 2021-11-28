//
//  RecruitingVC.swift
//  ThunderRing
//
//  Created by HM on 2021/11/28.
//

import UIKit

class RecruitingVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "모집 중인 번개", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .grayBackground)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
