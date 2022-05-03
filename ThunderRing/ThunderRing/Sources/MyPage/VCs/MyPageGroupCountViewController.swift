//
//  MyPageGroupCountViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/10.
//

import UIKit

import SnapKit
import Then

final class MyPageGroupCountViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "그룹", backButtonIsHidden: false, closeButtonIsHidden: true)
    
    private var groupTableView = UITableView(frame: .zero, style: .grouped)
    
    private var privateHeaderView = UIView()
    private var publicHeaderView = UIView()
    
    private var privateHeaderLabel = UILabel().then {
        $0.text = "비공개 그룹"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var privateGroupCountLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 18)
    }
    
    private var publicHeaderLabel = UILabel().then {
        $0.text = "공개 그룹"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var publicGroupCountLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 18)
    }
    
    private var privateGroupData = [PrivateGroupData]()
    private var publicGroupData = [PublicGroupData]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getPrivateGroupData()
            self.getPublicGroupData()
            self.groupTableView.reloadData()
        }
        configUI()
        configTabBarUI()
        setLayout()
        setTableView()
    }
    
    // MARK: - Init UI
    
    private func configTabBarUI() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func configUI() {
        view.backgroundColor = .background
        setStatusBar(.white)
        navigationBar.layer.applyShadow()
        
        [privateHeaderView, publicHeaderView].forEach {
            $0.backgroundColor = .background
        }
    }
    
    private func setLayout() {
        view.addSubviews([groupTableView, navigationBar])
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        groupTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview()
        }
        
        /// table headerview
        privateHeaderView.addSubviews([privateHeaderLabel, privateGroupCountLabel])
        publicHeaderView.addSubviews([publicHeaderLabel, publicGroupCountLabel])
        
        [privateHeaderLabel, publicHeaderLabel].forEach {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview().inset(15)
            }
        }
        
        privateGroupCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(14)
            $0.leading.equalTo(privateHeaderLabel.snp.trailing).offset(4)
        }
        
        publicGroupCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(14)
            $0.leading.equalTo(publicHeaderLabel.snp.trailing).offset(4)
        }
    }
    
    // MARK: - Custom Method
    
    private func setTableView() {
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
        groupTableView.separatorStyle = .none
        groupTableView.backgroundColor = .background
        groupTableView.showsVerticalScrollIndicator = false
        groupTableView.separatorInset = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
        
        groupTableView.register(PrivateListTableViewCell.self, forCellReuseIdentifier: PrivateListTableViewCell.identifier)
        groupTableView.register(PublicListTableViewCell.self, forCellReuseIdentifier: PublicListTableViewCell.identifier)
    }
}

extension MyPageGroupCountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return privateHeaderView
        } else {
            return publicHeaderView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 86
        case 1:
            return 86
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let dvc = PrivateDetailViewController()
            dvc.index = indexPath.row
            navigationController?.pushViewController(dvc, animated: true)
        case 1:
            let dvc = PrivateDetailViewController()
            navigationController?.pushViewController(dvc, animated: true)
        default:
            return
        }
    }
}

extension MyPageGroupCountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return privateGroupData.count
        } else {
            return publicGroupData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PrivateListTableViewCell.identifier) as? PrivateListTableViewCell else { return UITableViewCell() }
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.init(red: 126 / 255, green: 101 / 255, blue: 255 / 255, alpha: 0.1)
            cell.selectedBackgroundView = bgColorView
            
            if indexPath.row == 0 {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 6
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            if indexPath.row == privateGroupData.count - 1 {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 6
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            
            cell.initCell(privateGroupData[indexPath.row])
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PublicListTableViewCell.identifier) as? PublicListTableViewCell else { return UITableViewCell() }
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.init(red: 126 / 255, green: 101 / 255, blue: 255 / 255, alpha: 0.1)
            cell.selectedBackgroundView = bgColorView
            
            if indexPath.row == 0 {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 6
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            if indexPath.row == publicGroupData.count - 1 {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 6
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            
            cell.initCell(publicGroupData[indexPath.row])
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Network

extension MyPageGroupCountViewController {
    private func getPrivateGroupData() {
        guard
            let jsonData = self.loadPrivateGroupData(),
            let data = try? JSONDecoder().decode(PrivateGroupResponse.self, from: jsonData)
        else { return }
        privateGroupData = data.privateGroupData
        privateGroupCountLabel.text = "\(data.privateGroupData.count)"
    }
    
    private func getPublicGroupData() {
        guard
            let jsonData = self.loadPublicGroupData(),
            let data = try? JSONDecoder().decode(PublicGroupResponse.self, from: jsonData)
        else { return }
        publicGroupData = data.publicGroupData
        publicGroupCountLabel.text = "\(data.publicGroupData.count)"
    }
}

