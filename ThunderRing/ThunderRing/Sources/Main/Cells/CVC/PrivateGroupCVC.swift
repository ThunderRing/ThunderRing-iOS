//
//  PrivateGroupCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/05.
//

import UIKit

class PrivateGroupCVC: UICollectionViewCell {
    static let identifier = "PrivateGroupCVC"
    
    // MARK: - UI
    
    @IBOutlet weak var privateGroupTableView: UITableView!
    
    // MARK: - Properties
    
    private var privateGroups = [PrivateGroupDataModel]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTableView()
    }
}

extension PrivateGroupCVC {
    private func setTableView() {
        privateGroupTableView.delegate = self
        privateGroupTableView.dataSource = self
        
        privateGroupTableView.register(UINib(nibName: PrivateGroupTVC.identifier, bundle: nil), forCellReuseIdentifier: PrivateGroupTVC.identifier)
    }
    
    func initCell(groups: [PrivateGroupDataModel]) {
        privateGroups = groups
    }
}

extension PrivateGroupCVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = privateGroupTableView.dequeueReusableCell(withIdentifier: PrivateGroupTVC.identifier, for: indexPath) as? PrivateGroupTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.initCell(group: privateGroups[indexPath.row])
        return cell
    }
}
