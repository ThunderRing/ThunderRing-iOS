//
//  ThunderVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/11/07.
//

import UIKit

import SnapKit

final class LightningMainViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var groupListTableView: UITableView!
    
    private var privateHeaderView = UIView()
    private var publicHeaderView = UIView()
    
    private var privateHeaderLabel = UILabel().then {
        $0.text = "비공개 그룹"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var publicHeaderLabel = UILabel().then {
        $0.text = "공개 그룹"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        groupListTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bind()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        titleLabel.text = "번개 치기"
        [privateHeaderView, publicHeaderView].forEach {
            $0.backgroundColor = .background
        }
        
        searchTextField.setLeftIcon(17, 16, UIImage(named: "icnSearch")!)
        
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
        /// button
        closeButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        
        /// tableview
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        
        groupListTableView.separatorStyle = .none
        groupListTableView.backgroundColor = .background
        groupListTableView.showsVerticalScrollIndicator = false
        groupListTableView.separatorInset = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
        
        groupListTableView.register(PrivateListTableViewCell.self, forCellReuseIdentifier: PrivateListTableViewCell.identifier)
        groupListTableView.register(PublicListTableViewCell.self, forCellReuseIdentifier: PublicListTableViewCell.identifier)
    }
}

// MARK: - UITableView Delegate

extension LightningMainViewController: UITableViewDelegate {
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
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "LightningTitleViewController") as? LightningTitleViewController else { return }
        dvc.index = indexPath.row
        
        if indexPath.section == 0 {
            for i in 0 ... privateGroupData.count - 1 {
                dvc.groupNames.append(privateGroupData[i].groupName)
                dvc.groupMaxCounts.append(privateGroupData[i].memberCounts)
                dvc.groupMaxCount = privateGroupData[indexPath.row].memberCounts
            }
        } else {
            for i in 0 ... privateGroupData.count - 1 {
                dvc.groupNames.append(publicGroupData[i].groupName)
                dvc.groupMaxCounts.append(privateGroupData[i].memberCounts)
            }
        }
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            topView.layer.applyShadow()
        } else {
            topView.layer.applyShadow(color: UIColor.clear, alpha: 0, x: 0, y: 0, blur: 0, spread: 0)
        }
    }
}

// MARK: - UITableView DataSource

extension LightningMainViewController: UITableViewDataSource {
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
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.init(red: 126 / 255, green: 101 / 255, blue: 255 / 255, alpha: 0.1)
            cell.selectedBackgroundView = bgColorView
            
            if indexPath.row == 0 {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 9
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            if indexPath.row == privateGroupData.count - 1 {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 9
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
                cell.layer.cornerRadius = 9
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            if indexPath.row == publicGroupData.count - 1 {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 9
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
