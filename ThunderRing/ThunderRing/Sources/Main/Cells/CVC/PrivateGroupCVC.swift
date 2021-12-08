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
        
        initUI()
        setTableView()
    }
}

extension PrivateGroupCVC {
    private func initUI() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.gray350.cgColor
    }
    
    private func setTableView() {
        privateGroupTableView.delegate = self
        privateGroupTableView.dataSource = self
        
        privateGroupTableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        privateGroupTableView.separatorColor = .gray350
        privateGroupTableView.isScrollEnabled = false
        
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
