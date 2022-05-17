//
//  CompleteLightningVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/11/24.
//

import UIKit

final class CompleteLightningViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var confirmButton: UIButton!
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var groupName: String?
    var lightningName: String?
    var lightningDescription: String?
    var date: String?
    var time: String?
    var location: String?
    var minNumber: Int?
    var maxNumber: Int?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setAction()
    }
    
    // MARK: - Init UI
    
    private func initUI() {
        confirmButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 27, bounds: true)
    }
    
    // MARK: - Custom Method
    
    private func setAction() {
        confirmButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true)
            
//            self.appDelegate?.scheduleNotification(groupName: self.groupName!, lightningName: self.lightningName!)
        }), for: .touchUpInside)
    }
}
