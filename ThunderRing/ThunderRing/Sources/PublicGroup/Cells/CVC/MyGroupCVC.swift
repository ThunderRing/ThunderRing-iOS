//
//  MyGroupCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/10.
//

import UIKit

protocol MyGroupCVCDelegate {
    func touchUpTestButton()
    func touchUpCreateButton()
}

final class MyGroupCVC: UICollectionViewCell {
    static let identifier = "MyGroupCVC"

    // MARK: - UI
    
    @IBOutlet weak var groupTableView: UITableView!
    
    private lazy var headerView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private lazy var testButton = UIButton().then {
        $0.setImage(UIImage(named: "btnTest"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpTestButton), for: .touchUpInside)
    }
    
    private lazy var createButton = UIButton().then {
        $0.setImage(UIImage(named: "btnCreate"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpCreateButton), for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    var delegate: MyGroupCVCDelegate?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        setTableView()
        setTableHeaderView()
    }

}

// MARK: - Custom Methods

extension MyGroupCVC {
    private func initUI() {
        self.backgroundColor = .white
    }
    
    private func setTableView() {
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
        groupTableView.backgroundColor = .background
        groupTableView.separatorStyle = .none
        groupTableView.showsVerticalScrollIndicator = false
        
        groupTableView.register(MyGroupTVC.self, forCellReuseIdentifier: MyGroupTVC.identifier)
    }
    
    private func setTableHeaderView() {
        headerView.addSubviews([testButton, createButton])
        
        testButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.centerY.equalToSuperview()
        }
        
        createButton.snp.makeConstraints {
            $0.leading.equalTo(testButton.snp.trailing).offset(7)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpTestButton() {
        delegate?.touchUpTestButton()
    }
    
    @objc func touchUpCreateButton() {
        delegate?.touchUpCreateButton()
    }
}

// MARK: - UITableView Delegate

extension MyGroupCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.addAboveTheBottomBorderWithColor(color: .background)
        headerView.addBottomBorderWithColor(color: .background)
        return headerView
    }
}

// MARK: - UITableView DataSource

extension MyGroupCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publicGroupData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyGroupTVC.identifier) as? MyGroupTVC else { return UITableViewCell() }
        cell.initCell(group: publicGroupData[indexPath.row])
        
        if indexPath.row == 0 {
            cell.clipsToBounds = true
            cell.backView.layer.cornerRadius = 9
            cell.backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.backView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(1)
            }
        } else {
            cell.backView.snp.makeConstraints {
                $0.top.equalToSuperview()
            }
        }
        if indexPath.row == publicGroupData.count - 1 {
            cell.clipsToBounds = true
            cell.backView.layer.cornerRadius = 5
            cell.backView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
