//
//  JoinVC.swift
//  ThunderRing
//
//  Created by HM on 2021/12/05.
//

import UIKit

class JoinVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setAction()
    }
    
}

// MARK: - Custom Methods

extension JoinVC {
    func initUI() {
        view.backgroundColor = UIColor(red: 0.0 / 255.0 , green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.5)
        popUpView.layer.cornerRadius = 8
        
        joinButton.clipsToBounds = true
        joinButton.layer.cornerRadius = 9
        joinButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        cancelButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 9
        cancelButton.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    func setAction() {
        cancelButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        
        joinButton.addAction(UIAction(handler: { _ in
            NotificationCenter.default.post(name: NSNotification.Name("JoinLightning"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
    }
}
