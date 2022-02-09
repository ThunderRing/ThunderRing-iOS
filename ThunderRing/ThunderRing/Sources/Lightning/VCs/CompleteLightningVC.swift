//
//  CompleteLightningVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/24.
//

import FirebaseDatabase

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
    
    private let database = Database.database().reference()
    
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
            // MARK: - TODO REMOVE
            lightningData.append(LightningDataModel(groupName: self.groupName!, lightningName: self.lightningName!, description: self.lightningDescription, date: self.date!, time: self.time!, location: self.location!, minNumber: self.minNumber!, maxNumber: self.maxNumber!))
            
            alarmData.append(AlarmDataModel(isThunder: false, isLightning: true, isFailed: false, lightningName: self.lightningName!, description: self.time! + " | " +  self.location!, time: "방금", groupName: self.groupName!))
            
            // Firebase Datebase로 데이터 저장
            let lightningData: [String : Any] = [
                "lightningName" : self.lightningName as Any,
                "lightningDescription" : self.lightningDescription as Any,
                "date" : self.date as Any,
                "time" : self.time as Any,
                "location" : self.location as Any,
                "minNumber" : self.minNumber as Any,
                "maxNumber" : self.maxNumber as Any
            ]
            guard let name = self.groupName else { return }
            self.database.child(name).setValue(lightningData)

            self.dismiss(animated: true)
            
            self.appDelegate?.scheduleNotification(groupName: self.groupName!, lightningName: self.lightningName!)
        }), for: .touchUpInside)
    }
}
