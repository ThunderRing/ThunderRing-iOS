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
    
    // MARK: - Properties
    
    private var chatLists = [ChatListDataModel]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "채팅", backBtnIsHidden: true, closeBtnIsHidden: true, bgColor: .white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setTableView()
        setData()
    }
}

// MARK: - Custom Methods

extension ChatListVC {
    private func initUI() {
        topView.layer.applyShadow()
        titleLabel.addCharacterSpacing()
    }
    
    private func setTableView() {
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.separatorStyle = .none
        chatListTableView.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
        chatListTableView.backgroundColor = .background
        
        chatListTableView.register(ChatListTVC.self, forCellReuseIdentifier: ChatListTVC.identifier)
    }
    
    private func setData() {
        chatLists.append(contentsOf: [
            ChatListDataModel(groupImage: "imgRabbit", hashTag: "양파링 걸즈", title: "혜화역 혼가츠 먹어요!", subTitle: "안녕하세요!", count: 8, time: 1),
            ChatListDataModel(groupImage: "imgNintendo", hashTag: "동물의 숲", title: "모각공 할 사람", subTitle: "채팅을 먼저 시작해보세요..", count: 20, time: 1),
            ChatListDataModel(groupImage: "imgCrong", hashTag: "크롱", title: "아름관 세미나실 가자", subTitle: "채팅을 먼저 시작해보세요..", count: 4, time: 1)
            ])
    }
}

// MARK: - UITableView Delegate

extension ChatListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC else { return }
        dvc.chatTitle = "혜화역 혼가츠 먹어요!"
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
        cell.initCell(chatList: chatLists[indexPath.row])
        return cell
    }
}
