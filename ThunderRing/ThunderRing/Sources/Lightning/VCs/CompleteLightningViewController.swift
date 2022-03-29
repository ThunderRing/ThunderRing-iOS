//
//  CompleteLightningVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/11/24.
//

import FirebaseDatabase

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
    
    private let database = Database.database().reference()
    
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
            // FIXME: - Firebase Database와 연동
            alarmData.append(AlarmDataModel(alarmType: .lightning, lightningName: self.lightningName!, description: self.time! + " | " +  self.location!, time: "방금", groupName: self.groupName!))
            
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
