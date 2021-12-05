//
//  JoinVC.swift
//  ThunderRing
//
//  Created by HM on 2021/12/05.
//

import UIKit

class JoinVC: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }
    
}

extension JoinVC {
    func initUI() {
        
        popUpView.layer.cornerRadius = 8
        
        
    }
}
