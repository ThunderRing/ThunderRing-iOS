//
//  ChatListVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

class ChatListVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var chatListTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
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
        lineView.backgroundColor = .lightGray
        
        titleLabel.text = "채팅"
        titleLabel.textColor = .black
        titleLabel.font = .SpoqaHanSansNeo(type: .bold, size: 24)
        
        subTitleLabel.text = "24시간이 지난 후 채팅방은 사라집니다"
        subTitleLabel.textColor = .lightGray
        subTitleLabel.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private func setTableView() {
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.separatorStyle = .none
        chatListTableView.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
        
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
