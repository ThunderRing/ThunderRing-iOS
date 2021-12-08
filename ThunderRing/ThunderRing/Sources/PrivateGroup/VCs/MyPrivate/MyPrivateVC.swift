//
//  MyPrivateVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/08.
//

import UIKit

class MyPrivateVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    @IBOutlet weak var groupTableView: UITableView!
    
    private var headerView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private var createPrivateButton = UIButton().then {
        $0.setTitle("  비공개 그룹 생성", for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .regular, size: 14)
        $0.setImage(UIImage(named: "icnPlus"), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .purple100
    }
    
    // MARK: - Properties

    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTableHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setTableView()
        setAction()
    }
}

extension MyPrivateVC {
    private func initUI() {
        customNavigationBarView.backgroundColor = .white
        customNavigationBarView.layer.applyShadow()
        setStatusBar(.white)
        
        view.backgroundColor = .background
    }
    
    private func setTableHeaderView() {
        headerView.addSubview(createPrivateButton)
        
        createPrivateButton.snp.makeConstraints {
            $0.width.equalTo(323)
            $0.height.equalTo(48)
            $0.centerX.centerY.equalToSuperview()
        }
        
        createPrivateButton.layer.cornerRadius = 5
        createPrivateButton.layer.masksToBounds = true
    }
    
    private func setTableView() {
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
        groupTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        groupTableView.backgroundColor = .background
        
        groupTableView.register(MyPrivateTVC.self, forCellReuseIdentifier: MyPrivateTVC.identifier)
    }
    
    private func setAction() {
        createPrivateButton.addAction(UIAction(handler: { _ in
            guard let dvc = UIStoryboard(name: Const.Storyboard.Name.CreatePrivate, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Navigation) as? NavigationController else { return }
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
    }
}

extension MyPrivateVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.backgroundColor = .background
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88
    }
}

extension MyPrivateVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateGroupData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPrivateTVC.identifier) as? MyPrivateTVC else { return UITableViewCell() }
        cell.initCell(group: privateGroupData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
