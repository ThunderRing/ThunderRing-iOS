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
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 18)
    }
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bind()
    }
    
    private func configUI() {
        view.backgroundColor = .background
        setStatusBar(.white)
        customNavigationBarView.layer.applyShadow()
        
        groupTableView.separatorStyle = .none
        groupTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        groupTableView.backgroundColor = .background
        groupTableView.showsVerticalScrollIndicator = false
        
        headerView.addSubviews([titleLabel, countLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
    }
    
    private func bind() {
        groupTableView.delegate = self
        groupTableView.dataSource = self
        groupTableView.register(MyPrivateTableViewCell.self, forCellReuseIdentifier: MyPrivateTableViewCell.identifier)
        
        count = privateGroupData.count
        
        backButton.addAction(UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
        
        plusButton.addAction(UIAction(handler: { _ in
            guard let dvc = UIStoryboard(name: Const.Storyboard.Name.CreatePrivate, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Navigation) as? NavigationController else { return }
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
        
        searchButton.addAction(UIAction(handler: { _ in
            let dvc = SearchPrivateGroupVC()
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
    }
}


// MARK: - UITableView Delegate

extension MyPrivateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.backgroundColor = .background
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dvc = PrivateDetailViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - UITable DataSource

extension MyPrivateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateGroupData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPrivateTableViewCell.identifier) as? MyPrivateTableViewCell else { return UITableViewCell() }
        cell.initCell(group: privateGroupData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

