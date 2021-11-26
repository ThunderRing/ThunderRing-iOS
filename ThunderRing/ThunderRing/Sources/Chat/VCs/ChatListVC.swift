//
//  ChatListVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

class ChatListVC: UIViewController {

    // MARK: - UI
    @IBOutlet weak var customNavigationBarView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chatListTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "채팅", backBtnIsHidden: true, closeBtnIsHidden: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setTableView()
    }
}

// MARK: - Custom Methods

extension ChatListVC {
    private func initUI() {
        topView.layer.applyShadow()
    }
    
    private func setTableView() {
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.separatorStyle = .none
        chatListTableView.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
        chatListTableView.backgroundColor = .grayBackground
        
        chatListTableView.register(ChatListTVC.self, forCellReuseIdentifier: ChatListTVC.identifier)
    }
}

// MARK: - UITableView Delegate

extension ChatListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC else { return }
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - UITableView DataSource

extension ChatListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTVC.identifier) as? ChatListTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
}
