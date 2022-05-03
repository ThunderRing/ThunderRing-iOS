//
//  MyPrivateViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2021/12/08.
//

import UIKit

import SnapKit
import Then

final class MyPrivateViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var customNavigationBarView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var groupTableView: UITableView!
    
    private var headerView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "그룹"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 18)
    }
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
            countLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    private var privateGroupData = [PrivateGroupData]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getPrivateGroupData()
            self.groupTableView.reloadData()
        }
        configUI()
        setLayout()
        setData()
        setTableView()
        setAction()
    }
    
    // MARK: - Init UI
    
    private func configNavigationUI() {
        setStatusBar(.white)
        customNavigationBarView.layer.applyShadow()
    }
    
    private func configUI() {
        view.backgroundColor = .background
        
        groupTableView.separatorStyle = .none
        groupTableView.backgroundColor = .background
        groupTableView.showsVerticalScrollIndicator = false
    }
    
    private func setLayout() {
        headerView.addSubviews([titleLabel, countLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
    }
    
    // MARK: - Custom Method
    
    private func setData() {
        count = privateGroupData.count
    }
    
    private func setTableView() {
        groupTableView.delegate = self
        groupTableView.dataSource = self
        groupTableView.register(MyPrivateTableViewCell.self, forCellReuseIdentifier: MyPrivateTableViewCell.cellIdentifier)
    }
    
    private func setAction() {
        backButton.addAction(UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
        
        plusButton.addAction(UIAction(handler: { _ in
            guard let dvc = UIStoryboard(name: Const.Storyboard.Name.CreatePrivate, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Navigation) as? NavigationController else { return }
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
        
        searchButton.addAction(UIAction(handler: { _ in
            let dvc = SearchPrivateGroupViewController()
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
    }
    
    private func load() -> Data? {
        let fileNm: String = "PrivateGroupData"
        let extensionType = "json"
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            print("파일 로드 실패")
            return nil
        }
    }
}


// MARK: - UITableView Delegate

extension MyPrivateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.backgroundColor = .background
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dvc = PrivateDetailViewController()
        dvc.isOwner = true
        dvc.index = indexPath.row
        navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - UITable DataSource

extension MyPrivateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateGroupData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPrivateTableViewCell.cellIdentifier) as? MyPrivateTableViewCell else { return UITableViewCell() }
        cell.initCell(privateGroupData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}


// MARK: - Network

extension MyPrivateViewController {
    private func getPrivateGroupData() {
        guard
            let jsonData = self.load(),
            let data = try? JSONDecoder().decode(PrivateGroupResponse.self, from: jsonData)
        else { return }
        privateGroupData = data.privateGroupData
        count = data.privateGroupData.count
    }
}


