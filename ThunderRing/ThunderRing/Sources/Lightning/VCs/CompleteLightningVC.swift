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
    
    // MARK: - Properties
    
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
}

extension CompleteLightningVC {
    private func initUI() {
        confirmButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 27, bounds: true)
    }
    
    private func setAction() {
        confirmButton.addAction(UIAction(handler: { _ in
            lightningDatas.append(LightningDataModel(groupName: self.groupName!, lightningName: self.lightningName!, description: self.lightningDescription, date: self.date!, time: self.time!, location: self.location!, minNumber: self.minNumber!, maxNumber: self.maxNumber!))
            
            alarmDatas.append(AlarmDataModel(isThunder: false, isLightning: true, isFailed: false, lightningName: self.lightningName!, description: self.time! + " | " +  self.location!, time: "방금", groupName: self.groupName!))
            alarmDatas = alarmDatas.reversed()
            
            self.dismiss(animated: true) {
                dump(lightningDatas)
            }
            
            self.appDelegate?.scheduleNotification(groupName: self.groupName!, lightningName: self.lightningName!)
        }), for: .touchUpInside)
    }
}
