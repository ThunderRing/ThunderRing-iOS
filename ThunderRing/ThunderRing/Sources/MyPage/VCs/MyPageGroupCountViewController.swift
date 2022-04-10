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
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
        $0.addCharacterSpacing()
    }
    
    private var publicHeaderLabel = UILabel().then {
        $0.text = "공개 그룹"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
        $0.addCharacterSpacing()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - Init UI
    
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
        privateHeaderView.addSubview(privateHeaderLabel)
        publicHeaderView.addSubview(publicHeaderLabel)
        
        [privateHeaderLabel, publicHeaderLabel].forEach {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview().inset(15)
            }
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
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
            cell.initCell(group: privateGroupData[indexPath.row])
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
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PublicListTableViewCell.identifier) as? PublicListTableViewCell else { return UITableViewCell() }
            cell.initCell(group: publicGroupData[indexPath.row])
            
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
            return cell
        default:
            return UITableViewCell()
        }
    }
}
