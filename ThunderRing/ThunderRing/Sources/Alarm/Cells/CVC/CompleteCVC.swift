//
//  CompleteCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/10.
//

import UIKit

final class CompleteCVC: UICollectionViewCell {
    static let identifier = "CompleteCVC"

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    private var alarms = [AlarmDataModel]()
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTableView()
    }
    
    // MARK: - Custom Method
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .background
        
        let nib = UINib(nibName: AlarmTVC.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: AlarmTVC.identifier)
    }
    
    func setCellData(alarms: [AlarmDataModel]) {
        self.alarms = alarms
    }
}

// MARK: - UITableView Delegate

extension CompleteCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

// MARK: - UITableView DataSource

extension CompleteCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTVC.identifier) as? AlarmTVC else { return UITableViewCell() }
        let cellData = alarms[indexPath.row]
        cell.initCell(alarmType: cellData.alarmType, title: cellData.lightningName, description: cellData.description, time: cellData.time, hashTag: cellData.groupName)
        return cell
    }
}
