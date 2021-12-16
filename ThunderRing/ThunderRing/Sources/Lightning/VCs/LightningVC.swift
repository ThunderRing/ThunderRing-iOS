//
//  ThunderVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

import SnapKit
import Then

class LightningVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBackView: UIView!
    @IBOutlet weak var groupListTableView: UITableView!
    
    private lazy var privateHeaderView = UIView().then {
        $0.backgroundColor = .background
    }
    private lazy var publicHeaderView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private lazy var privateHeaderLabel = UILabel().then {
        $0.text = "비공개그룹"
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    private lazy var publicHeaderLabel = UILabel().then {
        $0.text = "공개그룹"
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.groupListTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        setAction()
        setTableHeaderView()
        setTableView()
        setTextField()
    }
}

extension LightningVC {
    private func initUI() {
        titleLabel.text = "번개 치기"
        titleLabel.addCharacterSpacing()
        
        searchBackView.backgroundColor = .background
    }
    
    private func setAction() {
        closeButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
    }
    
    private func setTableHeaderView() {
        privateHeaderView.addSubview(privateHeaderLabel)
        publicHeaderView.addSubview(publicHeaderLabel)
        
        [privateHeaderLabel, publicHeaderLabel].forEach {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview().inset(15)
            }
        }
    }
    
    private func setTableView() {
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        
        groupListTableView.separatorStyle = .none
        groupListTableView.backgroundColor = .background
        groupListTableView.showsVerticalScrollIndicator = false
        
        groupListTableView.register(PrivateListTVC.self, forCellReuseIdentifier: PrivateListTVC.identifier)
        groupListTableView.register(PublicListTVC.self, forCellReuseIdentifier: PublicListTVC.identifier)
    }
    
    private func setTextField() {
        searchTextField.setLeftIcon(17, 16, UIImage(named: "icnSearch")!)
    }
}

extension LightningVC: UITableViewDelegate {
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
            return 80
        case 1:
            return 96
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "SetLightningTitleVC") as? SetLightningTitleVC else { return }
        dvc.index = indexPath.row
        
        if indexPath.section == 0 {
            for i in 0 ... indexPath.row {
                dvc.groupNames.append(privateGroupData[i].groupName)
            }
        } else {
            dvc.groupNames = ["서울숲 플로깅", "05년생 모여", "서울중학교", "닌텐도 할 사람"]
        }
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            searchBackView.layer.applyShadow()
        } else {
            searchBackView.layer.applyShadow(color: UIColor.clear, alpha: 0, x: 0, y: 0, blur: 0, spread: 0)
        }
    }
}

extension LightningVC: UITableViewDataSource {
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PrivateListTVC.identifier) as? PrivateListTVC else { return UITableViewCell() }
            cell.initCell(group: privateGroupData[indexPath.row])
            cell.selectionStyle = .none
            
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PublicListTVC.identifier) as? PublicListTVC else { return UITableViewCell() }
            cell.initCell(groupImage: publicGroupData[indexPath.row].groupImage, groupName: publicGroupData[indexPath.row].groupName, count: publicGroupData[indexPath.row].memberCounts, hashTag: publicGroupData[indexPath.row].hashTag)
            cell.selectionStyle = .none
            
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
