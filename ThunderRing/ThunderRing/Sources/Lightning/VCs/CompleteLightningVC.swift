//
//  CompleteLightningVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/24.
//

import UIKit

class CompleteLightningVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setAction()
    }
    
}

extension CompleteLightningVC {
    private func initUI() {
        confirmButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 27, bounds: true)
    }
    
    private func setAction() {
        confirmButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
    }
}
