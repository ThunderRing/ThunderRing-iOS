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
        titleLabel.text = "번개 치기"
    }
    
    private func setAction() {
        closeButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
    }
    
    private func setData() {
        privateGroup.append(contentsOf: [
            PrivateGroupDataModel(groupImage: "image1", groupName: "양파링걸즈", memberCounts: 4),
            PrivateGroupDataModel(groupImage: "image1", groupName: "크롱", memberCounts: 30),
            PrivateGroupDataModel(groupImage: "image1", groupName: "오렌지쥬스", memberCounts: 7),
            PrivateGroupDataModel(groupImage: "image1", groupName: "마법사쥬쥬", memberCounts: 5)
        ])
        
        publicGroup.append(contentsOf: [
            PublicGroupDataModel(groupImage: "image1", groupName: "Rich ball", memberCounts: 3, hashTag: "사근한 오전"),
            PublicGroupDataModel(groupImage: "image1", groupName: "곰돌아이", memberCounts: 7, hashTag: "감성적인 새벽녁"),
            PublicGroupDataModel(groupImage: "image1", groupName: "동물의 숲", memberCounts: 3, hashTag: "감성적인 새벽녁"),
            PublicGroupDataModel(groupImage: "image1", groupName: "이지언니", memberCounts: 3, hashTag: "사근한 오전")
        ])
    }
    
    private func setTableView() {
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        
        groupListTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        
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
        view.tintColor = .black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .black
        header.textLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 18)
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
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PublicListTVC.identifier) as? PublicListTVC else { return UITableViewCell() }
            cell.initCell(groupImage: publicGroup[indexPath.row].groupImage, groupName: publicGroup[indexPath.row].groupName, count: publicGroup[indexPath.row].memberCounts, hashTag: publicGroup[indexPath.row].hashTag)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
