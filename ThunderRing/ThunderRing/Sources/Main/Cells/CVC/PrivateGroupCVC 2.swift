//
//  PrivateGroupCVC.swift
//  ThunderRing
//
//  Created by HM on 2021/11/22.
//

import UIKit

class PrivateGroupCVC: UICollectionViewCell {
    static let identifier = "PrivateGroupCVC"
    
    // MARK: - UI
    
    @IBOutlet weak var privateGroupTableView: UITableView!
    
    // MARK: - Properties
    
    private var privateGroups = [PrivateGroupDataModel]()
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        privateGroupTableView.delegate = self
        privateGroupTableView.dataSource = self
    }
}

extension PrivateGroupCVC {
    func initCell(groups: [PrivateGroupDataModel]) {
        privateGroups = groups
    }
}

extension PrivateGroupCVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let customCell = privateGroupTableView.dequeueReusableCell(withIdentifier: PrivateGroupTVC.identifier, for: indexPath) as? PrivateGroupTVC else { return UITableViewCell() }
        customCell.initCell(group: privateGroups[indexPath.row])
        return customCell
    }
    
}
