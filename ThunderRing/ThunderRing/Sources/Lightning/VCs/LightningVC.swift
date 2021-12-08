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
    @IBOutlet weak var searchBackView: UIView!
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
    
    private func setData() {
        privateGroup.append(contentsOf: [
            PrivateGroupDataModel(groupImage: "imgRabbit", groupName: "양파링걸즈", memberCounts: 4),
            PrivateGroupDataModel(groupImage: "imgCrong", groupName: "크롱", memberCounts: 30),
            PrivateGroupDataModel(groupImage: "imgButterfly", groupName: "오렌지쥬스", memberCounts: 7),
            PrivateGroupDataModel(groupImage: "imgJuju", groupName: "마법사쥬쥬", memberCounts: 7)
        ])
        
        publicGroup.append(contentsOf: [
            PublicGroupDataModel(groupImage: "imgRabbit", groupName: "Rich ball", memberCounts: 3, hashTag: "부지런한 동틀녘"),
            PublicGroupDataModel(groupImage: "imgBear", groupName: "곰돌아이", memberCounts: 7, hashTag: "북적이는 오후"),
            PublicGroupDataModel(groupImage: "imgNintendo", groupName: "동물의 숲", memberCounts: 3, hashTag: "감성적인 새벽녘"),
            PublicGroupDataModel(groupImage: "imgDog", groupName: "이지언니", memberCounts: 3, hashTag: "사근한 오전")
        ])
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
            return 80
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
            
            if indexPath.row == 0 {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 9
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            if indexPath.row == privateGroup.count - 1 {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 9
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PublicListTVC.identifier) as? PublicListTVC else { return UITableViewCell() }
            cell.initCell(groupImage: publicGroup[indexPath.row].groupImage, groupName: publicGroup[indexPath.row].groupName, count: publicGroup[indexPath.row].memberCounts, hashTag: publicGroup[indexPath.row].hashTag)
            cell.selectionStyle = .none
            
            if indexPath.row == 0 {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 9
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            if indexPath.row == privateGroup.count - 1 {
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
