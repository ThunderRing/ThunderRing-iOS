//
//  ThunderVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

class LightningVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var groupListTableView: UITableView!
    
    // MARK: - Properties
    
    var privateGroup = [PrivateGroupDataModel]()
    var publicGroup = [PublicGroupDataModel]()

    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        setAction()
        setData()
        setTableView()
    }
}

extension LightningVC {
    private func initUI() {
        titleLabel.text = ""
        view.backgroundColor = .background
    }
    
    private func setAction() {
        closeButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
    }
    
    private func setData() {
        privateGroup.append(contentsOf: [
            PrivateGroupDataModel(groupImage: "imgRabbit", groupName: "양파링걸즈", memberCounts: 4),
            PrivateGroupDataModel(groupImage: "imgRabbit", groupName: "크롱", memberCounts: 30),
            PrivateGroupDataModel(groupImage: "imgRabbit", groupName: "오렌지쥬스", memberCounts: 7)
        ])
        
        publicGroup.append(contentsOf: [
            PublicGroupDataModel(groupImage: "imgRabbit", groupName: "Rich ball", memberCounts: 3, hashTag: "사근한 오전"),
            PublicGroupDataModel(groupImage: "imgRabbit", groupName: "곰돌아이", memberCounts: 7, hashTag: "북적이는 오후"),
            PublicGroupDataModel(groupImage: "imgRabbit", groupName: "동물의 숲", memberCounts: 3, hashTag: "감성적인 새벽녘"),
            PublicGroupDataModel(groupImage: "imgRabbit", groupName: "이지언니", memberCounts: 3, hashTag: "부지런한 동틀녘")
        ])
    }
    
    private func setTableView() {
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        
        groupListTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        groupListTableView.backgroundColor = .background
        
        groupListTableView.register(PrivateListTVC.self, forCellReuseIdentifier: PrivateListTVC.identifier)
        groupListTableView.register(PublicListTVC.self, forCellReuseIdentifier: PublicListTVC.identifier)
    }
}

extension LightningVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "비공개 그룹"
        } else {
            return "공개 그룹"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .black
        header.textLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 147
        case 1:
            return 96
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "SetLightningTitleVC") as? SetLightningTitleVC else { return }
        
        if indexPath.section == 0 {
//            dvc.groupName = privateGroup[indexPath.row].groupName
            dvc.index = indexPath.row
        } else {
            dvc.groupName = publicGroup[indexPath.row].groupName
        }
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

extension LightningVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return privateGroup.count
        } else {
            return publicGroup.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PrivateListTVC.identifier) as? PrivateListTVC else { return UITableViewCell() }
            cell.initCell(groupImage: privateGroup[indexPath.row].groupImage, groupName: privateGroup[indexPath.row].groupName, count: privateGroup[indexPath.row].memberCounts)
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PublicListTVC.identifier) as? PublicListTVC else { return UITableViewCell() }
            cell.initCell(groupImage: publicGroup[indexPath.row].groupImage, groupName: publicGroup[indexPath.row].groupName, count: publicGroup[indexPath.row].memberCounts, hashTag: publicGroup[indexPath.row].hashTag)
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}
