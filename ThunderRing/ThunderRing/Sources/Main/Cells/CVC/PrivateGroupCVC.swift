//
//  PrivateGroupCVC.swift
//  ThunderRing
//
//  Created by HM on 2021/11/22.
//

import UIKit

class PrivateGroupCVC: UICollectionViewCell {
    static let identifier = "PrivateGroupCVC"
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var privateGroupTableView: UITableView!
    
    override func layoutSubviews()
        {
            super.layoutSubviews()
            privateGroupTableView.delegate = self
            privateGroupTableView.dataSource = self
        }
 
}

extension PrivateGroupCVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = privateGroupTableView.dequeueReusableCell(withIdentifier: PrivateGroupTVC.identifier, for: indexPath)as! PrivateGroupTVC
        
        return customCell
    }
    
}
