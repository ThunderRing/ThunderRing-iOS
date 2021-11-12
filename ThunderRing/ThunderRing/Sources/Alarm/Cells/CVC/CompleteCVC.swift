//
//  CompleteCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/10.
//

import UIKit

class CompleteCVC: UICollectionViewCell {
    static let identifier = "CompleteCVC"

    // MARK: - UI
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTableView()
    }

}

extension CompleteCVC {
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 38, left: 0, bottom: 0, right: 0)
        
        let nib = UINib(nibName: AlarmTVC.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: AlarmTVC.identifier)
    }
}

extension CompleteCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

extension CompleteCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTVC.identifier) as? AlarmTVC else { return UITableViewCell() }
        return cell
    }
}
