//
//  MyGroupCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/10.
//

import UIKit

class MyGroupCVC: UICollectionViewCell {
    static let identifier = "MyGroupCVC"

    // MARK: - UI
    
    @IBOutlet weak var groupTableView: UITableView!
    
    private lazy var headerView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private lazy var testButton = UIButton().then {
        $0.setTitle("성향 테스트", for: .normal)
        $0.setTitleColor(.purple100, for: .normal)
//        $0.setImage(UIImage(named: ""), for: .normal)
    }
    
    private lazy var createButton = UIButton().then {
        $0.setTitle("공개그룹 생성", for: .normal)
        $0.setTitleColor(.purple100, for: .normal)
//        $0.setImage(UIImage(named: ""), for: .normal)
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        setTableView()
        setTableHeaderView()
    }

}

extension MyGroupCVC {
    private func initUI() {
        self.backgroundColor = .white
    }
    
    private func setTableView() {
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
        groupTableView.separatorColor = .gray350
        groupTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        groupTableView.showsVerticalScrollIndicator = false
        
        groupTableView.register(MyGroupTVC.self, forCellReuseIdentifier: MyGroupTVC.identifier)
    }
    
    private func setTableHeaderView() {
        headerView.addSubviews([testButton, createButton])
        
        testButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(26)
            $0.centerY.equalToSuperview()
        }
        
        createButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(26)
            $0.centerY.equalToSuperview()
        }
    }
}

extension MyGroupCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}

extension MyGroupCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publicGroupData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyGroupTVC.identifier) as? MyGroupTVC else { return UITableViewCell() }
        cell.initCell(group: publicGroupData[indexPath.row])
        return cell
    }
}
